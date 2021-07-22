+++
title = "8. org-gcal"
tags = ["replacement"]
draft = false
+++

## 概要 {#概要}

[org-gcal](https://github.com/kidd/org-gcal.el) は org-mode と Google Calendar を連携させるためのパッケージ。

オリジナルは <https://github.com/myuhe/org-gcal.el> なのだけど今は fork されてるやつが MELPA にも登録されていて
el-get のレシピもそっちを見ている。


## インストール {#インストール}

org-gcal が依存しているので [parsist](https://elpa.gnu.org/packages/persist.html) を入れている。

```emacs-lisp
(el-get-bundle persist) ;; org-gcal に必要
```

あとは当然 org-gcal 本体を入れないと動かない

```emacs-lisp
(el-get-bundle org-gcal)
```


## 設定 {#設定}

とりあえず require をしないといけない

```emacs-lisp
(require 'org-gcal)
```

あとは設定ファイルは公開したくないので別ファイルに分けてる。

```emacs-lisp
(my/load-config "my-org-gcal-config")
```

隠したい部分だけ .authinfo.gpg にでも分離したら公開できるようになるかもしれない。


## その他 {#その他}

[gcal-org](https://github.com/misohena/gcal) に乗り換えようかと思ってるがそっちの中身もよくわからないので躊躇している。自分の用途に合うのだろうか?
