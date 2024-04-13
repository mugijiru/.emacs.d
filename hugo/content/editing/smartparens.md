+++
title = "smartparens"
draft = false
+++

## 概要 {#概要}

[smartparens](https://github.com/Fuco1/smartparens) はカッコとかクォートとかのペアになるようなものの入力補助をしてくれるやつ。

strict モードだとペアが崩れないように強制するので雑に C-k で行削除しててもペアが維持されて便利。


## インストール {#インストール}

いつも透り el-get で導入している

```emacs-lisp
(el-get-bundle smartparens)
```


## 設定 {#設定}

実は導入して間もないので、提供されてるオススメ設定のみ突っ込んでいる。オススメ設定は別途 reqiure したら良いという作りなので、以下のようにして突っ込んでいる。

```emacs-lisp
(require 'smartparens-config)
```


## Monkey patch {#monkey-patch}

今現在 `symbol definition void sp--syntax-class-to-char` というエラーが生じるので
<https://github.com/Fuco1/smartparens/issues/1204#issuecomment-2052434191> に書かれているコードを moneky patch として適用している

```emacs-lisp
;; monkey patch for symbol definition void sp--syntax-class-to-char
;; See: https://github.com/Fuco1/smartparens/issues/1204#issuecomment-2052434191
(defalias 'sp--syntax-class-to-char #'syntax-class-to-char)
```


## その他 {#その他}

各言語の hook で `smartparens-strict-mode` を有効にしている。なんか常に有効だと困りそうな気がしたので。
