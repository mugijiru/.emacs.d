+++
title = "scratch-log"
draft = false
+++

## 概要 {#概要}

[scratch-log](https://github.com/mori-dev/scratch-log) は、Emacs でちょっとした Emacs Lisp なんかを試し書きする時に使う `*scratch*` バッファを永続化してくれるパッケージ。

自分なんかは Emacs Lisp だけでなくちょっとメモを置いといたりもするので勝手に永続化してくれるこいつにはとてもお世話になっている。

GitHub の README には作者のブログへのリンクしかないしそのブログは消えてるので一番まともに解説しているのは <http://emacs.rubikitch.com/scratch-log/> だと思う。


## インストール {#インストール}

el-get のレシピを自前で用意して

```emacs-lisp
(:name scratch-log
       :type github
       :description "emacs の scratch バッファのログを取ります."
       :pkgname "mori-dev/scratch-log")
```

`el-get-bundle` で入れるだけ。

```emacs-lisp
(el-get-bundle scratch-log)
```


## 有効化 {#有効化}

どうも明示的に require しないといけないっぽくて、そうしている。ちょっと本当にそうなのか検証したい気はする。

```emacs-lisp
(require 'scratch-log)
```


## 類似品など {#類似品など}

[persistent-scratch](https://github.com/Fanael/persistent-scratch)
: これも scratch を永続化させるやつ。カスタマイズ性はこっちがありそう

[unkillable-scratch](https://github.com/EricCrosson/unkillable-scratch)
: scratch バッファを kill させないやつ。同じような機能が scratch-log にもある

[auto-save-buffers-enhanced](https://github.com/kentaro/auto-save-buffers-enhanced)
: 自動保存機能がメインだけど scratch を自動保存する機能もある
