+++
title = "keypression"
draft = false
+++

## 概要 {#概要}

[keypression](https://github.com/chuntaro/emacs-keypression) は Emacs 上でのキー操作を可視化してくれるツール。操作したキーを右下とかにダダダッと表示してくれるのでデモ動画を撮る時なんかに使うと便利なやつ


## インストール {#インストール}

el-get にはレシピがないので自前で用意している

```emacs-lisp
(:name keypression
       :website "https://github.com/chuntaro/emacs-keypression"
       :description "Keystroke visualizer for GUI version Emacs"
       :type github
       :branch "master"
       :pkgname "chuntaro/emacs-keypression")
```

そしてそれを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle keypression)
```


## 設定 {#設定}

あまり設定は弄っていないが、とりあえず child frame を使うようにしている

```emacs-lisp
(custom-set-variables
 '(keypression-use-child-frame t))
```
