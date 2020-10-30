---
title: "Multiple Git Push URLs"
date: 2020-08-27T18:36:35-04:00
tags: ["git"]
---

You can add multiple push urls to a single origin by using `git remote origin set-url --add --push <url>` . This is helpful if you have a repository hosted on Github and you would like to mirror it to Gitlab on every push.

By default git has a single remote url that is used for both push and pull. In the config you can configure multiple `pushurl` instead of relying on the `url` .

## Demo

This repository is currently configured just for Github

```shell
$ git remote -vv
origin  git@github.com:zqureshi/daily (fetch)
origin  git@github.com:zqureshi/daily (push)
```

I can set a `pushurl` to the same repo

```shell
$ git remote set-url --add --push origin git@github.com:zqureshi/daily
$ git remote -vv
origin  git@github.com:zqureshi/daily (fetch)
origin  git@github.com:zqureshi/daily (push)
```

Now I can add the Gitlab repo as another `pushurl`

```shell
$ git remote set-url --add --push origin git@gitlab.com:zqureshi/daily.git
$ git remote -vv
origin  git@github.com:zqureshi/daily (fetch)
origin  git@github.com:zqureshi/daily (push)
origin  git@gitlab.com:zqureshi/daily.git (push)
```

**Note:** The first step of setting the existing `url` as a `pushurl` is necessary because when you set a `pushurl` it overrides the current `url`. If I were to simply execute the second Gitlab command then I would be pushing to Gitlab and pulling from Github, which is not what we want.

A `git push` should now show multiple uploads

```shell
$ git push
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 1.56 KiB | 1.56 MiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:zqureshi/daily
   d0f3e61..34a57ac  master -> master
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 8 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 1.56 KiB | 1.56 MiB/s, done.
Total 4 (delta 2), reused 0 (delta 0), pack-reused 0
To gitlab.com:zqureshi/daily.git
  d0f3e61..34a57ac  master -> master
```

<!--more-->
