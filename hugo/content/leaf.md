+++
title = "leaf.el"
draft = false
+++

## 概要 {#概要}

[leaf.el](https://github.com/conao3/leaf.el) は日本の Emacs 界隈でよく使われている設定管理ユーティリティ。
Yet another [use-package](https://github.com/jwiegley/use-package) なのだけど、それの歯痒いところに対応しているとか。

個人的には el-get  に対応しているので使っていきたい。


## インストール/初期化 {#インストール-初期化}

el-get 本体にはレシピがないので自前で用意している。

```emacs-lisp
(:name leaf
       :website "https://github.com/conao3/leaf.el"
       :description "Yet another package manager for Emacs"
       :type github
       :branch "master"
       :pkgname "conao3/leaf.el")
```

そして `:el-get` キーワードを使いたいので `leaf-keywords.el` のレシピも用意している

```emacs-lisp
(:name leaf-keywords
       :website "https://github.com/conao3/leaf-keywords.el"
       :description "Add additional keywords for leaf.el"
       :type github
       :branch "master"
       :pkgname "conao3/leaf-keywords.el")
```

そして他のパッケージと同様にそれら `el-get-bundle` でインストールしている。インストールと同時に初期化も行っている。

```emacs-lisp
(el-get-bundle leaf)
(el-get-bundle leaf-keywords)
(leaf-keywords-init)
```

このあたりは el-get が入ってる前提で設定しているので公式 README とは異なる方法を採用している
