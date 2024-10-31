+++
title = "sql"
draft = false
+++

## 概要 {#概要}

たまには SQL を書くこともあるのでそのための設定を書いておく。とはいえ大体 org-mode の中で書くのだけれども。


## sqlformat {#sqlformat}

[sqlformat](https://github.com/purcell/sqlformat) は SQL コードのフォーマットをしてくれるパッケージです。フォーマットの方法は外部ツールに任せる感じなので、各自お気に入りの formatter を利用できます


## インストール {#インストール}

el-get 本体にレシピがないので自前で用意しています。

```emacs-lisp
(:name sqlformat
       :website "https://github.com/purcell/sqlformat"
       :description "Easily reformatting SQL using any one of several popular SQL formatters"
       :type github
       :pkgname "purcell/sqlformat"
       :depends (reformatter))
```

そして `el-get-bundle` でインストールしています

```emacs-lisp
(el-get-bundle sqlformat)
```


## 設定 {#設定}

普段 PostgreSQL を使うことが多いことと
manjaro の extra リポジトリにあったからという理由で
[pgformatter](https://github.com/darold/pgFormatter) を利用しています。

というわけで Emacs からもそれを使って format するように設定しています

```emacs-lisp
(setopt sqlformat-command 'pgformatter)
```
