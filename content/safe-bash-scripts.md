---
title: "Safe Bash Scripts"
date: 2020-08-26T15:24:25-04:00
tags: ["shell", "sysadmin"]
---

Starting bash scripts with `set -euxo pipefail` makes them safer.

- `set -e` exit immediately when a command fails.
- `set -o pipefail` fail pipeline if any of the commands fail. By default the rightmost command's exit code is used.
- `set -u` treat unset variables as an error and exit immediately.
- `set -x` print each command before executing.

See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

<!--more-->
