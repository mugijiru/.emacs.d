+++
title = "avy"
draft = false
+++

## 概要 {#概要}

[avy](https://github.com/abo-abo/avy) は好きな文字とか単語など、表示されてる場所にさくっとジャンプするためのパッケージ。
Vimium の f とかに似てる。


## インストール {#インストール}

el-get で普通にインストールしている

```emacs-lisp
(el-get-bundle avy)
```


## 設定 {#設定}

文字の上に重なると元の文字列がよくわからなくなるので、移動先の文字の前に表示するようにしている

```emacs-lisp
(setq avy-style 'pre)
```


## キーバインド {#キーバインド}

グローバルなキーバインドを汚染したくなかったのでひとまず Hydra を定義している。

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define avy-hydra
    (:separator "-" :title "avy" :foreign-key warn :quit-key "q" :exit t)
    ("Char"
     (("c" avy-goto-char       "Char")
      ("C" avy-goto-char-2     "Char 2")
      ("x" avy-goto-char-timer "Char Timer"))

     "Word"
     (("w" avy-goto-word-1 "Word")
      ("W" avy-goto-word-0 "Word 0"))

     "Line"
     (("l" avy-goto-line "Line"))

     "Other"
     (("r" avy-resume "Resume")))))
```

| Key | 効果            |
|-----|---------------|
| c   | 1文字からの絞り込み |
| C   | 2文字から絞り込み |
| x   | 任意の文字列からの絞り込み |
| w   | 1文字絞り込んで単語先頭に移動 |
| W   | 絞り込みなしの単語移動 |
| l   | 列移動          |
| r   | 繰り返し同じコマンドを実行 |
