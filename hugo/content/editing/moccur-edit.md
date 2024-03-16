+++
title = "moccur-edit"
draft = false
+++

## 概要 {#概要}

[moccur-edit](https://github.com/myuhe/moccur-edit.el) は [color-moccur](https://github.com/myuhe/color-moccur.el) で検索した結果を編集するためのツール。


## インストール {#インストール}

el-get 本体にレシピがあるのでそちらからインストールしている。

```emacs-lisp
(el-get-bundle moccur-edit)
```

なお EmacsWiki に moccur-edit も color-moccur もあるのだけど
color-moccur の方がソースコードが古めなので
GitHub から入れるのを推奨する。

el-get のレシピは GitHub を見ているので安心


## 設定 {#設定}

とりあえず color-moccur で migemo が使えると検索する時に便利なのでその機能を有効にしている。また、編集したところがわかりやすい方がいいかなと思ったので、そこをハイライトする設定も入れておいた

```emacs-lisp
(custom-set-variables
 '(moccur-use-migemo t)
 '(moccur-edit-highlight-edited-text t))
```
