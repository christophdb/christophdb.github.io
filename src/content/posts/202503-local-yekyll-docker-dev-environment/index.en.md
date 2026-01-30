---
title: "Setting Up a Local Development Environment for Jekyll with Docker"
date: "2025-03-12"
#description: "..."
summary: ""
categories: [Tutorial]
tags: 
  - Development
  - Docker
  - Linux
  - Jekyll
draft: false
permalink: '/2025/03/12/local-development-environment-for-jekyll-with-docker'

---

## Why?

own blog is fun. Full-blown wordpress to much. Writing a lighnight fast website just with markdown is aswesome.
Hosting it on github pages makes it super easy...

There are multiple builders. My first attemps is jekyll.

I don't want to install local dependencies like ruby. I want to keep my pc clean. I want to have a constitent working environment no matter on which pc i am sitting. Therefore I want to have a local docker base development environment.
Also I want to keep my page under version control with git. Updating my website should be like pushing a markdown file to github.

## My Battleplan

Image: 
- local folder with jekyll. 
- Pfeil 1: local development with docker. accessiable with port :4000. 
- Pfeil 2: push to github, github workflows, accessiable with github pages

So let's get my hands dirty...

## Build the setup

### 1. Install docker

... simple script

### 2. Create Dockerfile

This is the `Dockerfile`, to create our own jekyll container. It provides everything needed and expects, that jekyll is available in `/src/jekyll`.

```bash
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ruby \
    ruby-bundler \
    ruby-dev \
    nano \
    curl \
    build-essential \
    zlib1g-dev \
  && rm -rf /var/lib/apt/lists/*

RUN echo '# Install Ruby Gems to ~/gems' >> /root/.bashrc && \
    echo 'export GEM_HOME="$HOME/gems"' >> /root/.bashrc && \
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> /root/.bashrc

ENV GEM_HOME=/root/gems
ENV PATH=/root/gems/bin:$PATH

WORKDIR /srv/jekyll

RUN ruby --version && bundle --version && gem install bundler jekyll

CMD ["irb"]
```

### 3. Create docker-compose.yml and launch the container


Now it is time to create the local environment...

```yaml
---
services:
  jekyll:
    build: .
    container_name: jekyll_dev
    volumes:
      - .:/srv/jekyll
      - ./vendor/bundle/:/usr/local/bundle
      - ./gems/:/root/gems
    ports:
      - "4000:4000"
    command: sh -c "bundle && jekyll serve --force_polling --drafts --host 0.0.0.0"
```

## Use the setup

... how to initialize
... how to build...