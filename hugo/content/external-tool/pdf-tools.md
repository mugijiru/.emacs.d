+++
title = "pdf-tools"
draft = false
+++

## 概要 {#概要}

[pdf-tools]({{< relref "pdf-tools" >}}) は PDF を読む時にいい感じにしてくれるやつ。


## インストール {#インストール}

これは el-get 本体にレシピがあるので、単純にそのまま入れている

```emacs-lisp
(el-get-bundle pdf-tools)
```


## 設定 {#設定}

PDF を開いたら即使えるようにするため `pdf-loader-install` を実行している

```emacs-lisp
(pdf-loader-install)
```
