+++
title = "which-key"
draft = false
+++

## 概要 {#概要}

[which-key](https://github.com/justbur/emacs-which-key) は prefix となるキーを入力してしばらく操作しなかった場合に
minibuffer とかで「続けて押せるキーはこれだよ」ってのを示してくれるやつ。


## インストール {#インストール}

こいつは el-get 本体にレシピがあるので
`el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle which-key)
```


## 有効化 {#有効化}

特に設定は弄らないで有効化している

```emacs-lisp
(which-key-mode 1)
```
