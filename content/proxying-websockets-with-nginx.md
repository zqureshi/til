---
title: "Proxying Websockets With Nginx"
date: 2020-10-21T13:05:01-04:00
tags: ["systems", "networking", "nginx"]
---

WebSockets use HTTP/1.1 headers to do a handshake before establishing the binary connection. The client will set `Upgrade: websocket` and `Connection: upgrade` header values. Nginx's `proxy_pass` directive by default does not forward these headers as there are considered hop-by-hop headers.

Nginx also only uses `HTTP/1.0` by default for outbound requests. Therefore, we must override the HTTP version and set header values to make WebSockets work.

```nginx
server {
  listen 8080;
  server_name backend;
  location / {
    # Upgrade from http/1.0 which is the default.
    proxy_http_version 1.1;

    # If the headers are set then proxy them.
    # Nginx will drop any headers with empty values by default.
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection $http_connection;

    # Always a good idea to pass through real client IP.
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_pass http://backend:8080;
  }
}
```

See http://nginx.org/en/docs/http/websocket.html

<!--more-->
