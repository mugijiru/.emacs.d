+++
title = "yascroll"
draft = false
+++

## 概要 {#概要}

[yascroll](https://github.com/emacsorphanage/yascroll) は標準のスクロールバーとは異なるスクロールバーを表示するやつ。

デフォルトだと右側の fringe 領域に表示するのであまり邪魔にならないし表示領域を必要以上に狭めないので気に入っている。

最初に作られたっぽい記事は
[主張しないスクロールバーモード、yascroll.elをリリースしました - Functional Emacser](https://m2ym.hatenadiary.org/entry/20110401/1301617991)
にある。タイトル通り、あまり主張しない感じで良い。


## インストール {#インストール}

いつも通り el-get でインストールしている

```emacs-lisp
(el-get-bundle yascroll)
```


## 設定 {#設定}

```emacs-lisp
(setopt global-yascroll-bar-mode t)
```

これで大体いい感じに表示されるので便利。たまに表示されなくなることもあるが、まあそこまで重要なやつでもないのであまり気にしていない
