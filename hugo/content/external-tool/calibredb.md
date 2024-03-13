+++
title = "calibredb"
draft = false
+++

## 概要 {#概要}

[calibredb.el](https://github.com/chenyanming/calibredb.el) は電子書籍管理ツール [Calibre](https://calibre-ebook.com/) のデータを Emacs から弄ったりするためのパッケージ。同じことは Calibre からもできるんだけどやっぱり Emacs のインターフェースがある方が便利だよねってことで導入した。
[org-ref もサポートしているみたい](https://github.com/chenyanming/calibredb.el#configure-to-support-org-ref) だしね


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意。

```emacs-lisp
(:name calibredb
       :website "Yet another calibre client for emacs."
       :description "Fix current buffer automatically"
       :type github
       :branch "master"
       :depends (esxml)
       :pkgname "chenyanming/calibredb.el")
```

そしてそれを `el-get-bundle` で入れている。

```emacs-lisp
(el-get-bundle calibredb)
```


## 設定 {#設定}

今はとりあえず Calibre のライブラリのパスだけを指定している。

```emacs-lisp
(custom-set-variables
 '(calibredb-root-dir "~/calibre-library"))
```
