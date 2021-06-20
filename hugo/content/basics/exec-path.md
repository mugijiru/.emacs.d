+++
title = "exec-path"
draft = false
+++

## 概要 {#概要}

Emacs は通常最小限の環境変数しか利用しないようになっている。

が、それだと普段使う上で「ああ、このコマンドが使えなくてもどかしい……!」と感じてしまう。

そこで [exec-path-from-shell](https://github.com/purcell/exec-path-from-shell) というのを使って
Emacs が見える PATH 環境変数をシェルが見てる PATH 環境変数と揃うようにしている。


## インストール {#インストール}

いつも通り el-get からインストールしている

```emacs-lisp
(el-get-bundle exec-path-from-shell)
```


## 有効化 {#有効化}

理由は忘れたが Mac の環境でのみ有効化している。その内 Linux 環境でも有効化を試みた方が良さそう

```emacs-lisp
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))
```

なお、これでシェルと共通の環境変数が使われるようになるのは
[デフォルトでは `PATH` と `MANPATH` のみである](https://github.com/purcell/exec-path-from-shell/blob/bf4bdc8b8911e7a2c04e624b9a343164c3878282/exec-path-from-shell.el#L85-L89)


## その他 {#その他}

なぜか以下のようなコメントを書いていた。普段使っている zsh で持ってる PATH は使わないのだろうか? :thinking_face:

```emacs-lisp
;; for exec path
;; use .bashrc setted path
```
