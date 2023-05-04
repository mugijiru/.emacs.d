+++
title = "wakatime-mode"
draft = false
+++

## 概要 {#概要}

[wakatime-mode](https://github.com/wakatime/wakatime-mode) は [WakaTime](https://wakatime.com) というサービスと連携するためのパッケージ。

WakaTime は自分がどのプロジェクトの作業をしているかを計測してくれるようなツール。普段の行動の改善に使えるかもしれないので、なんとなく連携してみている。


## インストール {#インストール}

いつも通り el-get から入れている

```emacs-lisp
(el-get-bundle wakatime-mode)
```


## APIキーの設定 {#apiキーの設定}

APIキーは .authinfo.gpg に保存しているのでそこから引っ張り出している。

```emacs-lisp
(custom-set-variables
 '(wakatime-cli-path "/usr/bin/wakatime")
 '(wakatime-api-key (funcall (plist-get (nth 0 (auth-source-search :host "wakatime.com" :max 1)) :secret))))
```


## 有効化 {#有効化}

Emacs を使っている間は常に有効になっていて欲しいので
global-wakatime-mode を有効にしている。

```emacs-lisp
(global-wakatime-mode 1)
```

APIキーが取れてない時はやたらエラーを吐くので何かしら調整はしてもいいかもしれない。

```emacs-lisp
(if (boundp 'wakatime-api-key)
  (global-wakatime-mode 1))
```

みたいにして API キーが取れている時だけ有効にするとかね。
