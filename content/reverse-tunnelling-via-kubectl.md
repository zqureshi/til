---
title: "Reverse Tunnelling via Kubectl"
date: 2020-11-13T21:23:44-05:00
tags: ["sysadmin", "networking"]
---

While working on [kubectl-trace](https://github.com/iovisor/kubectl-trace) I needed to have the kubernetes pod be able to talk to a local HTTP service. `kubectl` supports setting up tunnels from the client to a pod but not in the opposite direction.

`kubectl exec` allows us to start a process and have bi-directional streaming between the client and the pod. So, in theory a reverse tunnel could be set up over these streams. It would look like
- Run local service on port 8080
- Start a process on the pod that listens on a port and streams data to stdout (and reads via stdin.)
- Start a process on the client that connects to port 8080 and streams data via stdin/stdout.
- Connect the stdout/stdin of client porxy to stdin/stdout of server proxy.

Luckily we already have a utility `socat` that can do most of this.

```bash
# Set up named pipes (fifo) for communication
$ mkfifo in out

# Start local server
$ python3 -m http.server 8080

# Make socat listen on fifo and connect to server
$ socat TCP4:localhost:8080,fork STDIO <in >out

# In a separate shell, make socat listen on pod
# Notice how it is writing to "in" and reading from "out" as they are connected to the socat above
$ kubectl exec -i pod/ubuntu -- socat TCP4-LISTEN:5000,bind=localhost,fork,reuseaddr STDIO >in <out

# Now curl-ing port 5000 from within the pod should work!
$ kubectl exec pod/ubuntu -- curl localhost:5000
```

Since this is a common use case `socat` has support for executing a process and swapping the streams. This removes the need for making explicit named pipes.

```bash
$ socat \
  TCP4:localhost:8080 \
  SYSTEM:'"kubectl exec -i pod/ubuntu -- socat TCP4-LISTEN:5000,bind=localhost,reuseaddr STDIO"'
```

<!--more-->
