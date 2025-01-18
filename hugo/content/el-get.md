+++
title = "el-get"
draft = false
+++

## 概要 {#概要}

[el-get](https://github.com/dimitri/el-get) は結構昔からあるパッケージ管理系のものの1つ。自前で recipe を書いてあっちこっちから入れられるので気に入ってずっと使っている


## インストール {#インストール}

まず el-get がインストールされるディレクトリを `load-path` に放り込んでいる。

```emacs-lisp
(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))
```

そして `el-get` が見つからない時はインストールするようにしている

```emacs-lisp
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
```

このあたりの記述は公式の README に書かれてるやつと一緒だと思う。大分前に設定しているから今は違うかもしれんけど


## レシピのフォルダ指定 {#レシピのフォルダ指定}

自前のレシピをいくつか用意しているのでそのフォルダを el-get で読めるようにしている

```emacs-lisp
(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes"))
```
