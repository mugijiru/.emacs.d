+++
title = "uniquify"
draft = false
+++

## 概要 {#概要}

同じ名前のファイルを開いている時に祖先のディレクトリ名を表示してくれてどこのファイルかわかりやすくしてくれるやつ。

すぐ親とかも同名でも、名前が違うところまで遡って表示してくれる。


## 有効化 {#有効化}

Emacs に標準で入ってるので require するだけで有効にできる

```emacs-lisp
(require 'uniquify)
```


## 設定 {#設定}

自分は `ファイル名<フォルダ名>` みたいな表示になる形式にしている。その方がファイル名が主という感じになって使いやすそうだなって。

そういう意味では `post-foward` の方が幅を使わない分良いかもしれない。いつか検討しても良いかもしれない。

```emacs-lisp
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
```
