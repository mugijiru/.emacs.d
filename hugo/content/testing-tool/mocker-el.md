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


## 副作用を伴う関数の扱い {#副作用を伴う関数の扱い}

基本的に入出力を置き換えるためのものなので副作用が処理の主体になるような関数には向いてなさそう。

ただ <https://github.com/sigma/mocker.el#examples> を見ていると
`output-generator` で副作用と同じ処理を書いてやるなどの逃げ道はありそう
