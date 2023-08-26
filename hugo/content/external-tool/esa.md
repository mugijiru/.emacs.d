+++
title = "esa.el"
draft = false
+++

## 概要 {#概要}

[esa.el](https://github.com/nabinno/esa.el) は [esa.io](https://esa.io/) と連携するためのパッケージ。大体直接 Web で書くので活用はできてない……


## インストール・設定 {#インストール-設定}

レシピは自前で用意している

```emacs-lisp
(:name esa
       :description "Interface to esa.io (\( ⁰⊖⁰)/)"
       :type github
       :pkgname "nabinno/esa.el")
```

そして el-get で入れている。

設定は別ファイルに分離している。authinfo に移動したい

```emacs-lisp
(el-get-bundle esa)
(my/load-config "my-esa-config")
```

けど今は esa 使ってないのよね。
