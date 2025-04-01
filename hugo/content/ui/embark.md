+++
title = "embark"
draft = false
+++

## 概要 {#概要}

[Embark](https://github.com/oantolin/embark) は操作コンテキストに応じたコマンドを教えてくれるツール。また expand-region のように選択しているコンテキストを広げてくれる機能もある


## インストール {#インストール}

el-get にはレシピがないので自前で定義している

```emacs-lisp
( :name emberk
  :website "https://github.com/oantolin/embark"
  :description "Conveniently act on minibuffer completions"
  :type github
  :pkgname "oantolin/embark"
  :depends (compat))
```

依存関係が少なくて良いですね。

で、これを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle embark)
```


## 設定 {#設定}

ひとまず Embark が起動している時に `?` を叩いたら
help が出るようにしている。というか ivy を導入しているので、これで ivy の絞り込みインターフェースが起動するようになっている。

```emacs-lisp
(setopt embark-help-key "?")
```

まだ導入して試している段階なのでこれ以上は設定していない
