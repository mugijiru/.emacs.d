+++
title = "auto-insert"
draft = false
+++

## 概要 {#概要}

auto-insert はファイルを新規作成した時にファイル名に応じたテンプレートを挿入する機能。

Emacs が標準で持ってるライブラリなのでインストールは不要


## 設定 {#設定}

Emacs の設定は .emacs.d の中に閉じ込めたいので
auto-insert のテンプレートも `~/.emacs.d/insert` に閉じ込める設定にしている。

```emacs-lisp
(setopt auto-insert-directory "~/.emacs.d/insert/")
```


## 有効化 {#有効化}

あとは単に有効化している。

```emacs-lisp
(auto-insert-mode 1)
```


## 他の設定 {#他の設定}

ファイル名を正規表現でマッチさせてテンプレートが選択されるので各言語やフレームワーク毎に設定を入れることにしている。

実際は今のところ inits/41-vue.el でのみ追加設定を入れている。
