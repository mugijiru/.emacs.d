+++
title = "wgrep"
draft = false
+++

## 概要 {#概要}

[wgrep](https://github.com/mhayashi1120/Emacs-wgrep) は grep などでの検索結果バッファから直接ファイル編集ができるやつ。

類似品に [moccur-edit]({{< relref "moccur-edit" >}}) もあるけど外部ツールを使う分速いみたい。その代わり migemo は使えない。


## インストール {#インストール}

こいつは el-get 本体にレシピがあるので単にインストールするだけで OK

```emacs-lisp
(el-get-bundle wgrep)
```

特に設定はしていない
