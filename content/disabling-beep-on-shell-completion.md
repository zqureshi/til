---
title: "Disabling Beep on Shell Completion"
date: 2020-10-20T11:18:21-04:00
tags: ["shell", "zsh"]
---

ZSH by default emits a terminal bell on auto-completion which can be irritating.

```bash
unsetopt LIST_BEEP
```

See https://blog.vghaisas.com/zsh-beep-sound/

> LIST_BEEP
> Beep  on  an  ambiguous  completion.   More  accurately, this forces the completion widgets to return status 1 on an ambiguous completion, which causes the shell to beep if the option BEEP is also set; this may be modified if completion is called from a user-defined widget.

A related setting is:

> HIST_BEEP
> Beep in ZLE when a widget attempts to access a history entry which isn't there.

<!--more-->
