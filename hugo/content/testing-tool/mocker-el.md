+++
title = "mocker.el"
tags = ["unused"]
draft = false
weight = 2
+++

## 概要 {#概要}

[mocker.el](https://github.com/sigma/mocker.el) は Emacs Lisp のテストで使う Mock ライブラリ。

使おうと思って導入したけど、自分のやりたいことはちょっと違ったので死蔵中

便利そうなのでとりあえず置いといている。


## インストール {#インストール}

レシピを自前で用意して

```emacs-lisp
(:name mocker.el
       :type github
       :description "Mocker.el is a mocking framework for Emacs lisp."
       :pkgname "sigma/mocker.el"
       :minimum-emacs-version (25 1))
```

el-get で GitHub から取得している。

```emacs-lisp
(el-get-bundle mocker.el)
```
