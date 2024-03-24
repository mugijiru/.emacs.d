+++
title = "emojify"
draft = false
+++

## 概要 {#概要}

[emojify](https://github.com/iqbalansari/emacs-emojify) は `:smile:` のような入力を笑顔の絵文字が表示されたりするようにするパッケージ。

文書を書く時に emojify で絵文字に置き換わるような文字列を入れておくと文書が華やかになって良いぞ!


## インストール {#インストール}

いつも通り el-get で入れている。何か依存でもあるのが別途 dash.el も読み込んでる。

```emacs-lisp
(el-get-bundle emojify)
(el-get-bundle dash)
```

dash.el は他でも使うので、ライブラリの読み込みのところで対応した方が良さそうだな。今度対応しよう。


## 有効化 {#有効化}

emojify は正直邪魔になることも多いのでグローバルでは有効にしていない。

一方 mode-line では有効になるようにしている。とはいえ mode-line で絵文字が表示された記憶はないけれども。

```emacs-lisp
(global-emojify-mode -1)
(global-emojify-mode-line-mode 1)
```
