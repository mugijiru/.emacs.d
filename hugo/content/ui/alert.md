+++
title = "alert"
draft = false
+++

## 概要 {#概要}

[alert](https://github.com/jwiegley/alert) は色々な通知システムに対応した通知を飛ばせるパッケージ。
Mac だと Growl だったり terminal-notifier だったり
Win だと toast だったり
Linux だと libnotify だったりを使ってその環境での標準的な通知機能を使って通知ができるやつ。


## インストール {#インストール}

いつも通りに el-get でインストール。

```emacs-lisp
(el-get-bundle alert)
```


## 設定 {#設定}

業務では Mac を使ってるので terminal-notifier を設定している。他の環境では大人しく message にしている。

```emacs-lisp
(if (or (eq window-system 'ns) (eq window-system 'mac))
    (setq alert-default-style 'notifier) ;; use terminal-notifier
  (setq alert-default-style 'message))
```

本当は WSL2 でもいい感じに通知されるようにしたいが
[WSLで通知を出すメモ - cobodoのブログ](https://cobodo.hateblo.jp/entry/2018/03/08/160247)
とかを見てるとちょっと面倒そうなのでまた今度にする。
