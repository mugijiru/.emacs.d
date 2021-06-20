+++
title = "zoom"
draft = false
+++

## 概要 {#概要}

[zoom](https://github.com/cyrus-and/zoom) はフォーカスが当たっている Window が大きく表示されるようにするやつ。最近流行りのビデオチャットツールではない。

どこにフォーカスが当たっているかわかりやすくなるし、狭い画面でも見たい部分を広げて表示できるので便利。


## インストール {#インストール}

いつも通り el-get から入れる。
GitHub から直接取得するように設定している。

```emacs-lisp
(el-get-bundle cyrus-and/zoom)
```


## 設定 {#設定}

起動時に有効化
: 1画面しか使えない時は必須なので

比率を黄金比に変更
: この方が使いやすいっぽい。

という設定をしている。

```emacs-lisp
(custom-set-variables
 '(zoom-mode t)
 '(zoom-size '(0.618 . 0.618)))
```
