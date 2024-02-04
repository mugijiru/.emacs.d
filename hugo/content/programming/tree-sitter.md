+++
title = "tree-sitter"
draft = false
+++

## 概要 {#概要}

ここでは今現在は、
tree-sitter が使えることを自動判定して mode を切り替えて
tree-sitter の文法定義が存在しなければ自動的にインストールしてくれる
[treesit-auto](https://github.com/renzmann/treesit-auto) 用の設定を記述している


## インストール {#インストール}

treesit-auto のレシピは自前で用意している

```emacs-lisp
(:name treesit-auto
       :website "https://github.com/renzmann/treesit-auto"
       :description "Automatically install and use tree-sitter major modes in Emacs 29+."
       :type github
       :branch "main"
       :pkgname "renzmann/treesit-auto")
```

そしていつも通り `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle treesit-auto)
```


## 設定 {#設定}

インストール時には一応確認してほしいので、確認が入るような設定にしている

```emacs-lisp
(custom-set-variables
 '(treesit-auto-install 'prompt))
```


## 有効化 {#有効化}

require した上で global に有効化している

```emacs-lisp
(require 'treesit-auto)

(global-treesit-auto-mode)
```
