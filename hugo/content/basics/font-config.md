+++
title = "font-config"
draft = false
+++

## 概要 {#概要}

Emacs で利用するフォントの設定。それなりの設定をしないとガタついたりするので通常あまり手を入れないで済ませている。


## 設定 {#設定}

Mac では 14, それ以外(Linux) では 12 を基準としている。

Mac と Linux で基準のサイズを変えているがなぜかこの方がガタガタもしないし大き過ぎもしないしでいい感じになる。

```emacs-lisp
(let* ((size (if (or (eq window-system 'ns) (eq window-system 'mac)) 14 12))
       (asciifont "Ricty Diminished")      ; ASCII fonts
       (jpfont "Ricty Diminished")         ; Japanese fonts
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec)
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))
```
