---
title: "Tunnels With Socat"
date: 2020-10-29T15:11:13-04:00
tags: ["sysadmin", "networking"]
---

`socat` is a general purpose tool for bidirectional network forwarding. You can set up a simple tunnel on localhost like:

```bash
$ socat TCP-LISTEN=5000,bind=localhost,reuseaddr,fork TCP:192.168.1.22:80
```

You can leverage `socat` to link container ports, e.g. when developing `kubectl-trace` locally I want my docker registry to push to minikube's registry.

```bash
$ docker run -d \
  --restart=always \
  --name='minikube-registry-proxy' \
  --network=host \
  alpine \
  ash -c "apk add socat && socat TCP-LISTEN:5000,reuseaddr,fork TCP:$(minikube ip):5000"
```

See https://www.redhat.com/sysadmin/getting-started-socat

<!--more-->
