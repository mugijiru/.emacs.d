+++
title = "GraphQL"
draft = false
+++

## 概要 {#概要}

GraphQL は API 向けのクエリ言語でよく対比される REST と違いクライアント側から必要なデータ属性を指定できたりするやつ


## graphql-mode {#graphql-mode}

`*.graphql` ファイルを編集する時のメジャーモード


### インストール {#インストール}

こいつは el-get にレシピが用意されてないので自前で用意している

```emacs-lisp
(:name graphql-mode
       :description "An emacs mode to edit GraphQL schema and queries."
       :type github
       :pkgname "davazp/graphql-mode")
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle graphql-mode)
```


### hooks {#hooks}

graphql ファイルを弄る時に合わせて使いたい minor-mode があるのでそれらを有効にする hook を用意している

```emacs-lisp
(defun my/graphql-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (highlight-indent-guides-mode 1)
  (display-line-numbers-mode 1))
```

それぞれ以下の効果がある

[company-mode]({{< relref "company-mode" >}})
: 補完候補を出してくれる

[smartparens-strict-mode]({{< relref "smartparens" >}})
: カッコの対応を崩さないような編集ができるようなる

[highlight-indent-guides-mode]({{< relref "highlight-indent-guides" >}})
: インデントを見易くしてくれる

display-line-numbers-mode
: 左側に行数表示を出してくれる

そしてこの hook を `graphql-mode-hook` に突っ込んでいる

```emacs-lisp
(add-hook 'graphql-mode-hook 'my/graphql-mode-hook)
```


## graphql {#graphql}

こちらは GraphQL API を Emacs Lisp から叩くためのライブラリ。命名的にややこしいけど。


### インストール {#インストール}

こちらは el-get 本体にレシピがあるのでそのままインストールしている

```emacs-lisp
(el-get-bundle graphql)
```
