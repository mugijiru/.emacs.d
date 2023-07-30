+++
title = "font-config"
draft = false
+++

## 概要 {#概要}

Emacs で利用するフォントの設定。それなりの設定をしないとガタついたりするので通常あまり手を入れないで済ませている。


## 設定 {#設定}

Mac では 14, それ以外(Linux) では 18 を基準としている。

Mac と Linux で基準のサイズを変えているがなぜかこの方がガタガタもしないし大き過ぎもしないしでいい感じになる。

といいつつ元々 Linux の方は WSL2 環境に合わせて 12 にしていたが
Manjaro 環境に合わせて 18 に変更しているのでまたその内 WSL2 でも Manjaro でもどっちいい感じに使えるように調整するかもしれない

```emacs-lisp
(defun my/set-font-size (size)
  (let* ((asciifont "Ricty Diminished")      ; ASCII fonts
         (jpfont "Ricty Diminished")         ; Japanese fonts
         (h (* size 10))
         (fontspec (font-spec :family asciifont))
         (jp-fontspec (font-spec :family jpfont)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
    (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
    (set-fontset-font nil '(#x0080 . #x024F) fontspec)
    (set-fontset-font nil '(#x0370 . #x03FF) fontspec)))

(if (or (eq window-system 'ns) (eq window-system 'mac))
    (my/set-font-size 14)
  (my/set-font-size 18))
```

フォントの設定する処理は関数に切り出しているので全体的にフォントを大きくしたい時は

```emacs-lisp
(my/set-font-size 24)
```

のようにさくっと変更できるようにしている
