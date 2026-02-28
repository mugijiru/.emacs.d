+++
title = "el-get-lock"
draft = false
+++

## 概要 {#概要}

[el-get-lock](https://github.com/tarao/el-get-lock) は el-get にバージョンロック機構を追加するパッケージ。
随分メンテされてないのでいつ動かなくなってもおかしくないけど
私のパッケージ管理はこいつが要になってるので動き続けて欲しい


## インストール {#インストール}

こいつは `el-get-bundle` で入れている。
レシピなくても入れられるのだけど他に合わせてレシピを用意している

```emacs-lisp
(:name el-get-lock
       :website "https://github.com/tarao/el-get-lock"
       :description "Lock El-Get package repository versions"
       :type github
       :pkgname "tarao/el-get-lock")
```

```emacs-lisp
;; el-get のバージョンロック機構の導入
(el-get-bundle el-get-lock)
```


## 初期化 {#初期化}

とりあえず起動時に初期化する必要があるので初期化している。
その際に cl パッケージを require しないといけないのでそれも合わせてやっている

```emacs-lisp
(require 'cl)
(el-get-lock)
```
