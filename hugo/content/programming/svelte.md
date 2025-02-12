+++
title = "Svelte"
draft = false
+++

## 概要 {#概要}

[svelte-mode](https://github.com/leafOfTree/svelte-mode) は [Svelte](https://svelte.jp/) を書く時に使う major-mode


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している。

```emacs-lisp
(:name svelte-mode
       :website "https://github.com/leafOfTree/svelte-mode"
       :description "Emacs major mode for .svelte files."
       :type github
       :pkgname "leafOfTree/svelte-mode"
       :branch "master"
       :minimum-emacs-version "26.1")
```

これを使って `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle svelte-mode)
```


## 設定 {#設定}

使い始めでまだ何も設定していない
