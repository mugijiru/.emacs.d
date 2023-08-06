+++
title = "color-theme-molokai"
draft = false
+++

## 概要 {#概要}

[color-theme-molokai](https://github.com/sonatard/color-theme-molokai) は多分 vim の molokai をベースにしたテーマ。更に元はどうも TextMate っぽい。

ダークグレイ背景をベースにしたテーマでもう何年もこのテーマを使っている。


## インストール {#インストール}

el-get のレシピを自前で用意している

```emacs-lisp
(:name color-theme-molokai
  :type github
  :description "A pretty color theme."
  :pkgname "alloy-d/color-theme-molokai")
```

そして el-get で入れている。

```emacs-lisp
(el-get-bundle color-theme-molokai)
```


## テーマへの PATH を通す {#テーマへの-path-を通す}

インストールしただけでは custom-theme-load-path には追加されないので自分で add-to-list を使って PATH を通している。

```emacs-lisp
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/el-get/color-theme-molokai"))
```


## テーマの読み込み {#テーマの読み込み}

最後に load-theme で molokai を読み込んでいる。

```emacs-lisp
(load-theme 'molokai t)
```


## その他 {#その他}

もう長年これを使っているが、近年ではもっと良いテーマも出ているかもしれないのでそのうち乗り換えるかも。

なんだけど、テーマ乗り換えるのちょっとだるいのよね〜。
