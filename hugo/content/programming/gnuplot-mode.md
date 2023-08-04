+++
title = "gnuplot-mode"
draft = false
+++

## 概要 {#概要}

[gnuplot-mode](https://github.com/emacsorphanage/gnuplot) はグラフ作成ソフトである [gnuplot](http://www.gnuplot.info/) を Emacs で使うためのパッケージ。
Syntax Highlight や 補完機能 などを提供する。

まあほとんど使ってないんだけど。


## インストール {#インストール}

レシピは自前で用意している

```emacs-lisp
(:name gnuplot-mode
       :description "Drive gnuplot from within emacs"
       :type github
       :pkgname "emacs-gnuplot/gnuplot"
       :branch "main"
       :build `(("make" ,(concat "EMACS=" el-get-emacs))))
```

そしていつも通り el-get で入れている

```emacs-lisp
(el-get-bundle gnuplot-mode)
```


## その他 {#その他}

org-mode から使ってた記憶があるのでそっちの方で何か設定があるかもしれない
