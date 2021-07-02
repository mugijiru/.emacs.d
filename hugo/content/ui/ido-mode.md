+++
title = "ido-mode"
draft = false
+++

## 概要 {#概要}

Emacs に標準添付の補完インターフェース。
ivy 使ってるからこれ有効化している意味がない気はする。

拡張入れてない段階でもこいつを有効にしていると
find-file とかが楽になって良い。


## 有効化 {#有効化}

とりあえず昔からずっと有効化している

```emacs-lisp
(ido-mode 1)
```


## 設定 {#設定}

ファイル名の補完とかを曖昧一致を有効にするっぽいい。

```emacs-lisp
(setq ido-enable-flex-matching t)
```


## その他 {#その他}

<https://qiita.com/tadsan/items/33ebb8db2271897a462b> に書いていることだけど

-   ido-everywhere を有効にするとファイル名とバッファ切替以外にも使えるようになるらしい
-   smex 入れると M-x が強化される
-   ido-ubiquitous を入れると ido-everywhere よりもさらに色々な他に使えるらしい
-   ido-vertical-mode を入れたら候補が縦並びになって便利っぽい
