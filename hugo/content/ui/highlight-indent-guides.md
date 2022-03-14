+++
title = "highlight-indent-guides"
draft = false
+++

## 概要 {#概要}

[highlight-indent-guides](https://github.com/DarthFennec/highlight-indent-guides) はインデント毎にラインを引いたりして見易くしてくれるパッケージ。通常のプログラムを書く時にも便利だけど、
YAML などのインデントがそのまま構造になるような言語を弄る時にとても便利。


## インストール {#インストール}

これもいつも通り el-get でインストールしている。
GitHub にあるのでそこを直接指定してインストールもできるのだけど
el-get.lock からアップデートをチェックする都合上、レシピを用意してそれを使ってインストールしている

```emacs-lisp
(:name highlight-indent-guides
       :website "https://github.com/DarthFennec/highlight-indent-guides"
       :description "This minor mode highlights indentation levels via font-lock"
       :type github
       :pkgname "DarthFennec/highlight-indent-guides")
```

```emacs-lisp
(el-get-bundle highlight-indent-guides)
```


## 設定 <span class="tag"><span class="improvement">improvement</span></span> {#設定}

今いる行がどのインデントにいるのかをわかりやすくするために
responsive モードを有効にしている。

```emacs-lisp
(setq highlight-indent-guides-responsive "stack")
```

defcustom で定義されてる変数なので
custom-set-variables で設定した方がいいかもしれない。
