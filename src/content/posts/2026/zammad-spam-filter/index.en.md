---
title: "How to Auto-Block Spam in Zammad with a Simple Docker Middleware"
date: 2026-04-08
description: |
  Tired of spam tickets in Zammad? Learn how to build a lightweight FastAPI middleware that automatically creates Postmaster filters when agents tag a ticket as spam. One tag, no more emails from that sender — ever.
tags:
  - Zammad
  - Docker
  - Self-hosted
  - Automation
  - Python
url: '/zammad-auto-block-spam'
---

If you're running a self-hosted Zammad instance, you know the pain: spam emails slip through, create tickets, and clutter your helpdesk. Agents waste time closing junk tickets that should never have been created in the first place.

Zammad offers **Postmaster filters** that can block senders before a ticket is even created — but adding them manually for every spammer gets tedious fast. What if your agents could simply tag a ticket as "spam" and the sender gets blocked automatically?

That's exactly what this small middleware does.

## The Concept

The workflow is dead simple:

1. An agent sees a spam ticket and adds the tag **"Spam"**
2. A Zammad trigger detects the tag and fires a webhook
3. A lightweight middleware receives the webhook, extracts the sender's email
4. The middleware creates a Postmaster filter via the Zammad API
5. All future emails from that sender are silently ignored

```text
Agent tags ticket "Spam"
  → Zammad Trigger fires Webhook
    → Middleware extracts sender email
      → Postmaster filter created via API
        → Future emails from sender are ignored
```

No more manual filter creation. No more spam tickets from repeat offenders.

## Prerequisites

- A self-hosted **Zammad** instance
- **Docker** and **Docker Compose**
- A Zammad API token with `admin.channel_email` permission

## Step 1: Create a Zammad API Token

In Zammad, go to **Profile > Token Access** and create a new token:

- **Name:** `spam-filter-bot`
- **Permission:** `admin.channel_email`

Save the token — you'll need it for the middleware configuration.

## Step 2: The Middleware

The middleware is a minimal FastAPI application with a single endpoint. It receives the webhook payload from Zammad, extracts the sender's email address, checks for duplicates, and creates a Postmaster filter.

```python
# spam_filter.py
import hashlib
import hmac
import logging
import os

from fastapi import FastAPI, HTTPException, Request
import httpx

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(name)s: %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
)
logger = logging.getLogger("spam_filter")

app = FastAPI()

ZAMMAD_URL = os.environ["ZAMMAD_URL"]
ZAMMAD_TOKEN = os.environ["ZAMMAD_TOKEN"]
WEBHOOK_SECRET = os.environ.get("WEBHOOK_SECRET")

@app.post("/zammad-spam")
async def handle_spam(request: Request):
    body = await request.body()

    if WEBHOOK_SECRET:
        signature = request.headers.get("X-Hub-Signature", "")
        expected = "sha1=" + hmac.new(
            WEBHOOK_SECRET.encode(), body, hashlib.sha1
        ).hexdigest()
        if not hmac.compare_digest(signature, expected):
            raise HTTPException(status_code=403, detail="Invalid signature")

    data = await request.json()
    customer = data.get("ticket", {}).get("customer", {})
    sender = customer.get("email")

    if not sender:
        logger.info("No sender found in webhook payload")
        return {"status": "no sender found"}

    async with httpx.AsyncClient() as client:
        resp = await client.get(
            f"{ZAMMAD_URL}/api/v1/postmaster_filters",
            headers={"Authorization": f"Token {ZAMMAD_TOKEN}"},
        )
        existing = resp.json()
        if any(f["name"] == f"Spam-Block: {sender}" for f in existing):
            logger.info("Already blocked: %s", sender)
            return {"status": "already blocked", "sender": sender}

        resp = await client.post(
            f"{ZAMMAD_URL}/api/v1/postmaster_filters",
            headers={
                "Authorization": f"Token {ZAMMAD_TOKEN}",
                "Content-Type": "application/json",
            },
            json={
                "name": f"Spam-Block: {sender}",
                "match": {"from": {"operator": "contains", "value": sender}},
                "perform": {"x-zammad-ignore": {"operator": "is", "value": "true"}},
                "active": True,
                "channel": "email",
            },
        )

    logger.info("Blocked: %s (Zammad: %s)", sender, resp.status_code)
    return {"status": "blocked", "sender": sender}
```

## Step 3: Dockerize It

Create three files next to `spam_filter.py`:

**Dockerfile:**
```dockerfile
FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY spam_filter.py .
EXPOSE 8484
CMD ["uvicorn", "spam_filter:app", "--host", "0.0.0.0", "--port", "8484"]
```

**requirements.txt:**
```text
fastapi
uvicorn
httpx
```

**docker-compose.yml:**
```yaml
services:
  spam-filter:
    build: .
    image: zammad-spam-filter
    container_name: zammad-spam-filter
    restart: unless-stopped
    ports:
      - "8484:8484"
    env_file:
      - .env
```

**.env:**
```text
ZAMMAD_URL=https://your-zammad-instance.com
ZAMMAD_TOKEN=your-api-token
WEBHOOK_SECRET=your-optional-secret
```

Start it:
```bash
docker compose up -d
```

## Step 4: Configure Zammad

### Create a Webhook

Go to **Manage > Webhook > New Webhook**:

| Field | Value |
|---|---|
| Name | Spam-Filter Webhook |
| Endpoint | `http://zammad-spam-filter:8484/zammad-spam` |
| HMAC SHA1 Signature Token | Same value as `WEBHOOK_SECRET` in your `.env` |
| SSL verification | No (if using HTTP) |

### Create a Trigger

Go to **Manage > Trigger > New Trigger**:

- **Name:** Spamlist
- **Activated by:** Action
- **Execution:** Always (important — "Selective" may not detect tag changes)
- **Condition:** Tags > contains one > `Spam`
- **Actions:**
  - Status → closed
  - Webhook → Spam-Filter Webhook

## Using It

That's it. From now on, the workflow for your agents is:

1. See a spam ticket
2. Add the tag **"Spam"**
3. Done — the ticket gets closed and the sender is permanently blocked

All created filters are visible and manageable under **Channels > Email > Filter** in Zammad. If a sender was blocked by mistake, simply delete the corresponding filter.

## What About Blocking on the Mail Server?

You could also block spam senders directly on your mail server so the emails never even reach Zammad. Most mail servers (Mailcow, Postfix, etc.) offer blacklisting via API or configuration. While this sounds appealing, it has a practical downside: blocked senders become invisible. There's no easy way to review or undo them from within Zammad. With Postmaster filters, every block is visible under **Channels > Email > Filter** — your agents can review, correct, or remove them at any time without touching the mail server.

## A Note on Security

If Zammad and the spam-filter container run on the **same Docker network**, you don't need to expose port 8484 at all. Remove the `ports` section from `docker-compose.yml` and have Zammad reach the middleware by container name (`http://zammad-spam-filter:8484/zammad-spam`). In this setup, the endpoint is not reachable from outside — no HMAC secret or additional hardening required.

If, however, the webhook travels over a network that others can reach (e.g., Zammad runs on a different host), you should:

- Set the `WEBHOOK_SECRET` so the middleware verifies every request via HMAC signature
- Consider putting the middleware behind a reverse proxy with TLS
- Restrict access to the endpoint by IP if possible

In short: same Docker network = no extra effort. Anything else = treat it like a public endpoint and secure accordingly.

## Conclusion

With roughly 80 lines of Python and a simple Docker container, you get a spam-blocking workflow that feels native to Zammad. Agents don't need API access or admin privileges — they just tag and move on. The middleware handles the rest, and every filter it creates is fully transparent and reversible through Zammad's UI.
