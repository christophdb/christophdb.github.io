---
title: "Caddy Labels Docker"
date: 2025-09-10
draft: true
nosearch: true
#image: images/robots2.jpg
#imageAltAttribute: xxx
#tags: 
#  - a
#  - b
#permalink: '/2025/02/21/xx'
---


Caddy Lucas Lorentz Proxy beispiele

    caddy: "file.seatable.com"
    caddy.reverse_proxy: "{{ upstreams 8080 }}"

    labels:
      caddy: "188.245.178.175.nip.io"
      #caddy.log:
      # simply return hello world
      #caddy.respond: "\"Hello World\""

      # simply return a fileserver, showing content of /tmp (numbers for ordering)
      #caddy.1_root: "* /tmp"
      #caddy.2_file_server: "browse"

      # two different routes
      caddy.handle_path_0: "/file*"
      caddy.handle_path_0.file_server: "browse"
      caddy.handle_path_0.root: "* /tmp"
      caddy.handle_path_1: "/*"
      caddy.handle_path_1.respond: "\"Hello World\""


caddy.handle_path_0: "/*"
      caddy.handle_path_0.reverse_proxy: "https://host.docker.internal:3080"
      caddy.handle_path_0.reverse_proxy.transport: "http"
      caddy.handle_path_0.reverse_proxy.transport.tls: ""
      caddy.handle_path_0.reverse_proxy.transport.tls_insecure_skip_verify: ""
      caddy.handle_path_1: "/web/login*"
      caddy.handle_path_1.reverse_proxy: "https://host.docker.internal:3080"
      caddy.handle_path_1.tls.client_auth.mode: "require_and_verify"
      caddy.handle_path_1.tls.client_auth.trust_pool: "file"
      caddy.handle_path_1.tls.client_auth.trust_pool.pem_file: "/data/caddy/ca.cert"

      weitere beispiele finden...


Wie testen:

docker logs caddy 
docker stop caddy
docker compose up -d
docker exec caddy cat /config/caddy/Caddyfile.autosave

