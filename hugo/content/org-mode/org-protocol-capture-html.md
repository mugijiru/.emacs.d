+++
title = "org-protocol-capture-html"
draft = false
+++

## 概要 {#概要}

[org-protocol-capture-html](https://github.com/alphapapa/org-protocol-capture-html) は [Pandoc](https://pandoc.org/) やブックマークレットと組み合わせて
Web ページを org-capture で保存できるようにするやつ。

Emacs 25.1 以降なら eww の機能を使って Web ページの表記を丸ごと capture できるので
Firefox の拡張機能 [org-capture-extension](https://github.com/sprig/org-capture-extension) を使って capture するよりも便利。


## インストール {#インストール}

org-protocol-capture-html はあまりちゃんとメンテされていないようなのと自分の環境では `eval-when-compile` の際にコンパイルされて定義されるはずの関数が定義されないので
[自分で fork したやつ](https://github.com/mugijiru/org-protocol-capture-html/)を使っている

というわけでレシピも自前で用意している。

```emacs-lisp
(:name org-protocol-capture-html
       :description "Capture HTML from the browser selection into Emacs as org-mode content."
       :type github
       :pkgname "mugijiru/org-protocol-capture-html"
       :branch "master"
       :minimum-emacs-version "25.1"
       :depends (org-mode s))
```

そしてそれを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle org-protocol-capture-html)
```

このパッケージは audoload も指定されていないのでとりあえず require して全部読み込むようにしている

```emacs-lisp
(require 'org-protocol-capture-html)
```
