+++
title = "server"
draft = false
+++

## 概要 {#概要}

Emacs の起動後にサーバとして動くようにしている。

これにより emacsclient コマンドで接続するとサーバとして動いている Emacs に別端末から繋げられたりする。

けど麦汁さんは Firefox から org-capture を動かすためにだけ利用している。


## 設定 {#設定}

`server.el` を require しておいてサーバとして動いていなかったらサーバとして動くようにしている。多重起動の防止ですね。

```emacs-lisp
(require 'server)
(unless (server-running-p)
  (server-start))
```


## 関連ツール {#関連ツール}

[org-capture-extension](https://github.com/sprig/org-capture-extension)
: org-capture 連携するための Chrome 及び Firefox の拡張。麦汁さんはこれを Firefox で使ってる。

[org-protocol-capture-html](https://github.com/alphapapa/org-protocol-capture-html)
: HTML コンテンツを org-mode の記述に変換して capture してくれるやつ。Pandoc 利用。


## その他 {#その他}

起動処理の最後に動けばいいので
init-loader で 99 を割り振っている。

init-loader をやめるなら多分 after-init-hook を使うことになるのかな。
