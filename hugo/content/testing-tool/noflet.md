+++
title = "noflet"
draft = false
+++

## 概要 {#概要}

ローカル定義の関数を用意するためのパッケージ。

ref: <http://emacs.rubikitch.com/noflet/>

テストする際に副作用を持つ関数を置き換えるのに便利。例えば <https://github.com/mugijiru/emacs-kibela/pull/14/commits/da54ad30473d65539efd884f30693e1d4707067b>
では noflet に差し替えてテストしている。


### mocker.el との使い分け {#mocker-dot-el-との使い分け}

[mocker.el]({{< relref "mocker-el" >}}) は関数を stub/mock するのには悪くないのだけどその関数が副作用を持っていて、その副作用の結果を反映した状態を実現するのには向いてなさそうなので
emacs-kibela のテストでは noflet を採用したという経緯がある


## インストール {#インストール}

noflet は el-get 本体の recipe として登録されているので
`el-get-bundle` で入れるだけで良い

```emacs-lisp
(el-get-bundle noflet)
```
