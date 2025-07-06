+++
title = "auth-source"
draft = false
+++

## 概要 {#概要}

[auth-source](https://www.gnu.org/software/emacs/manual/html_mono/auth.html) は Emacs でパスワードのような秘匿情報を扱うための仕組み。
Emacs の各パッケージが認証情報を要求する時にこいつ経由で取得できるようにしておくと秘匿もできて便利っぽい。

パスワードの保存先はデフォルトだと
`("~/.authinfo" "~/.authinfo.gpg" "~/.netrc")`
となっている。

拡張子が gpg だと [EagyPG Assistant](https://www.gnu.org/software/emacs/manual/html_mono/epa.html) で保存時に暗号化されるので便利。


## ファイル指定 {#ファイル指定}

自分は Emacs でしか使わないであろう情報ということで
`/.emacs.d/.authinfo.gpg` を指定している。

```emacs-lisp
(setopt auth-sources '("~/.emacs.d/.authinfo.gpg"))
```
