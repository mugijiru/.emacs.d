+++
title = "ace-window"
draft = false
+++

## 概要 {#概要}

Window 間の移動を ace-jump や avy のように表示されてる文字の Window に移動するやつ。

Window が2分割の時は文字も出ないで別の Window に移動してくれる。

`C-x o` にデフォルトで設定されている `other-window` は別の window に順番に移動するコマンドなので大量に分割していると移動がしんどいのだが
ace-window を使うと起動して 1 ストロークで移動できるので
`C-x o` をデフォルトの `other-window` から `ace-window` そのまま置き換えても便利に使える。


## インストール {#インストール}

いつも通り el-get でインストールしている。

```emacs-lisp
(el-get-bundle ace-window)
```


## 設定 {#設定}

キーバインドは別の箇所で定義しているが
`C-x o` で ace-window が起動するようにしている。

また Hydra からは ace-swap-window が起動できるようにしている。

ace-window には色々な機能があるからそれ用の Hydra を別途定義してもいいかもしれない。

ace-window 起動時に選択可能な数字が各 buffer の中央にいい感じに表示されるようにするため
ace-window-posfrme-mode を有効にしている

```emacs-lisp
(with-eval-after-load 'ace-window
  (ace-window-posframe-mode t))
```
