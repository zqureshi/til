---
title: "Using Docker Packages With Go Modules"
date: 2020-10-30T13:22:49-04:00
tags: ["golang", "development"]
---

If you are building something with recent golang versions you are most probably using go modules. If you try to import a docker struct

```go
package main

import (
	"github.com/moby/moby/container"
)

func main() {
	c := container.Container{}
	if c.Root == "0xDEADBEEF" {
		c.Root = ""
	}
}
```

and then build it

```bash
$ go build .
```

You'll get an error with dependency collisions

```
go: github.com/zqureshi/docker-test imports
    github.com/moby/moby/container imports
    github.com/Sirupsen/logrus: github.com/Sirupsen/logrus@v1.7.0: parsing go.mod:
    module declares its path as: github.com/sirupsen/logrus
            but was required as: github.com/Sirupsen/logrus
```

This is because there were breaking changes with the `logrus` import path and both docker/moby have since fixed the issue but because these projects don't use modules, go's dependency resolution imports ancients version of these packages.

The solution is to tell go to import latest versions of these packages explicitly.


```bash
$ go get github.com/moby/moby@master
$ go get github.com/docker/docker@master
$ go get github.com/docker/swarmkit@master
$ go get github.com/opencontainers/runc@master
```

The last import will give you some warning about cgo but ignore that as we're not using cgo.

Your `go.mod` file should now look like

```
module github.com/zqureshi/docker-test

go 1.15

require (
	github.com/docker/docker v20.10.0-beta1.0.20201028220007-bb23f1bf61cb+incompatible // indirect
	github.com/docker/swarmkit v1.12.1-0.20200728174709-d6592ddefd8a // indirect
	github.com/moby/moby v20.10.0-beta1.0.20201028220007-bb23f1bf61cb+incompatible // indirect
	github.com/opencontainers/runc v1.0.0-rc92.0.20201029234006-cf6c074115d0 // indirect
)
```

And the build should now succeed!

<!--more-->
