+++
title = "notify-slack"
draft = false
+++

## 概要 {#概要}

Emacs から Slack に通知するための自作関数。実体は同じく自作の外部コマンドを叩いているだけである。

何に使ってるかというと
org-clock-in, org-clock-out の時に作業の開始と終了を分報チャンネルに投稿しているだけである。作業の可視化である。


## 実装 {#実装}


### 分報チャンネル設定用の変数 {#分報チャンネル設定用の変数}

通知先のチャンネル名を格納する変数が必要なので `defvar` で定義しておく

```emacs-lisp
(defvar my/notify-slack-times-channel nil)
```


### 送信するコマンド {#送信するコマンド}

start-process を使って外部コマンドを叩いている。

```emacs-lisp
(defun my/notify-slack (channel text)
  (if my/notify-slack-enable-p
      (start-process "my/org-clock-slack-notifier" "*my/org-clock-slack-notifier*" "my-slack-notifier" channel text)))
```

`my/notify-slack-enable-p` という変数が nil だと大分コマンドが実行されないようになっている。


### Slack 連携を Toggle するコマンド {#slack-連携を-toggle-するコマンド}

連携したい時としたくない時があるので送信したりしなかったりを切り替えられるコマンドを用意している。

中身は何をしているかというと上に書いた `my/notify-slack-enable-p` という変数を切り替えているだけ。

```emacs-lisp
(defun my/notify-slack-toggle ()
  (interactive)
  (if my/notify-slack-enable-p
      (setq my/notify-slack-enable-p nil)
    (setq my/notify-slack-enable-p t)))
```


### 分報チャンネル投稿関数 {#分報チャンネル投稿関数}

「分報チャンネル投稿関数」としているけどデフォルト投稿先に投稿するための関数というような扱いの関数。

単純に前出の `my/notify-slack` 関数の第一引数に `my/notify-slack-times-channel` という変数を設定してそのチャンネルに向けて投稿するだけ。

```emacs-lisp
(defun my/notify-slack-times (text)
  (if my/notify-slack-times-channel
      (my/notify-slack my/notify-slack-times-channel text)))
```


### 設定 {#設定}

あまり見せたくない設定ファイルを別ファイルに分離しているのでそれを読み出している。

内部では `my/notify-slack-times-channel` という変数を設定しているだけじゃないだろうか。職場の Slack のチャンネルを指定しているので隠したいという意図があった。

そのうち .authinfo.gpg に移動しようと思ってる。

```emacs-lisp
(my/load-config "my-notify-slack-config")
```

ちなみに [my/load-config]({{< relref "load-path#my-load-config" >}}) はこの手の設定ファイルを読み出すために使っている自作関数である。
load と同じように使えば大体 OK。むしろ load の引数ちゃんと使えばこの関数要らない説まである。

そして起動直後は連携を ON にしたいので
`my/notify-slack-enable-p` を ON にしている

```emacs-lisp
(setq my/notify-slack-enable-p t)
```
