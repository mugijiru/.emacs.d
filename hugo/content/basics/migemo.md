+++
title = "migemo"
draft = false
+++

## 概要 {#概要}

[migemo.el](https://github.com/emacs-jp/migemo) は [cmigemo](https://github.com/koron/cmigemo) などと通信して、日本語入力オフのままローマ字入力をして日本語検索ができるようにするパッケージ。

これとても便利で抜け出せない。


## インストール {#インストール}

いつも通り el-get でインストール。

```emacs-lisp
(el-get-bundle migemo)
(load "migemo")
```

load はする必要あるのかわからんけど、そういう設定が既に入ってるのでそのままにしている。


## Mac での辞書の位置の指定 {#mac-での辞書の位置の指定}

Homebrew で cmigemo を入れているのでそれに合わせて辞書の位置を指定している。

```emacs-lisp
;; Mac
(let ((path "/usr/local/share/migemo/utf-8/migemo-dict"))
  (if (file-exists-p path)
      (setq migemo-dictionary path)))
```


## Ubuntu での辞書の位置の指定 {#ubuntu-での辞書の位置の指定}

apt で cmigemo を入れているのでそれに合わせて辞書の位置を指定している。

```emacs-lisp
;; Ubuntu
(let ((path "/usr/share/cmigemo/utf-8/migemo-dict"))
  (if (file-exists-p path)
      (setq migemo-dictionary path)))
```


## cmigemo コマンドの PATH 指定 {#cmigemo-コマンドの-path-指定}

環境で PATH が変わるので which コマンドの結果を migemo-command に設定している。

```emacs-lisp
(let ((path (s-chomp (shell-command-to-string "which cmigemo"))))
  (if (s-ends-with? "not found" path)
      (message "cmigemo not found")
    (setq migemo-command path)))
```


## オプション設定 {#オプション設定}

裏側で動くのでうるさくならないように `-q` を指定しているのと
Emacs から叩くから `--emacs` を指定しているだけ。

```emacs-lisp
(setq migemo-options '("-q" "--emacs"))
```


## coding system の指定 {#coding-system-の指定}

Mac と Ubuntu でしか使わないしそれらの環境だと統一で utf-8-unix でいいよねってことでそれを指定している。

```emacs-lisp
(setq migemo-coding-system 'utf-8-unix)
```

今時なら euc とかにする必要もないだろうしね。


## 初期化 {#初期化}

以上の設定を入れた上で初期化をしている。

```emacs-lisp
(migemo-init)
```
