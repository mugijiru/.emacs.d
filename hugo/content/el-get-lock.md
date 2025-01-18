+++
title = "el-get-lock"
draft = false
+++

## 概要 {#概要}

[el-get-lock](https://github.com/tarao/el-get-lock) は el-get にバージョンロック機構を追加するパッケージ。随分メンテされてないのでいつ動かなくなってもおかしくないけど私のパッケージ管理はこいつが要になってるので動き続けて欲しい


## インストール {#インストール}

こいつは `el-get-bundle` で入れている。
GitHub で管理されているし master ブランチを使っているし依存関係も el-get だけなのでレシピも作らずにインストールしている

```emacs-lisp
;; el-get のバージョンロック機構の導入
(el-get-bundle tarao/el-get-lock)
```


## 初期化 {#初期化}

とりあえず起動時に初期化する必要があるので初期化している。その際に cl パッケージを require しないといけないのでそれも合わせてやっている

```emacs-lisp
(require 'cl)
(el-get-lock)
```
