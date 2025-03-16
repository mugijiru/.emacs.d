+++
title = "toolbar"
draft = false
+++

## 概要 {#概要}

Emacs 標準の toolbar の設定。麦汁さんは使わないし幅を取るので隠す派。


## 設定 {#設定}

単に無効にして隠している

```emacs-lisp
(tool-bar-mode -1)
```

あと設定ファイルを増やすのだだるかったのでここでついでに menu-bar も無効にしている。手抜き……。

```emacs-lisp
(menu-bar-mode -1)
```
