+++
title = "zoom"
draft = false
+++

## 概要 {#概要}

[zoom](https://github.com/cyrus-and/zoom) はフォーカスが当たっている Window が大きく表示されるようにするやつ。最近流行りのビデオチャットツールではない。

どこにフォーカスが当たっているかわかりやすくなるし、狭い画面でも見たい部分を広げて表示できるので便利。


## インストール/設定 {#インストール-設定}

el-get のレシピは自前で用意している

```emacs-lisp
(:name zoom
       :type github
       :description "Fixed and automatic balanced window layout."
       :pkgname "cyrus-and/zoom"
       :minimum-emacs-version (24 4))
```

そして leaf を使って el-get で入れている
GitHub から直接取得するように設定している。

設定は最低限で

起動時に有効化
: 1画面しか使えない時は必須なので

比率を黄金比に変更
: この方が使いやすいっぽい。

という設定をしている。

```emacs-lisp
(leaf zoom
  :url "https://github.com/cyrus-and/zoom"
  :el-get cyrus-and/zoom
  :custom
  (zoom-mode . t)
  (zoom-size . '(0.618 . 0.618)))
```
