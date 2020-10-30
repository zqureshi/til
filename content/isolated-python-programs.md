---
title: "Isolated Python Programs"
date: 2020-08-31T12:49:53-04:00
tags: ["python", "shell"]
---

I usually don't install python packages globally, instead keeping one virtualenv per utility and linking from a directory in `$PATH` . For example, to install `httpie` I'd do

```bash
$ python3 -m venv ~/.virtualenvs/http
$ cd ~/.virtualenvs/http && source ./bin/activate
$ pip install --upgrade pip
Successfully installed pip-20.2.2
$ pip install httpie
Successfully installed httpie-2.2.0
```

This instance of `httpie` can be used by sourcing the `venv`

```bash
$ source ~/.virtualenvs/http/bin/activate
$ http --version
2.2.0
```

I usually also don't like to source an env globally and wrap it in a script. I have `~/.opt/bin` in `$PATH` and I'll create `~/.opt/bin/http` .

```bash
#!/usr/bin/env bash
set -euo pipefail

source ~/.virtualenvs/http/bin/activate
http "$@"
```

Now I can use it easily without sourcing.

<!--more-->
