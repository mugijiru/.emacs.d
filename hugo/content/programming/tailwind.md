+++
title = "TailwindCSS"
draft = false
+++

## 概要 {#概要}

[TailwindCSS](https://tailwindcss.com/) は Utility First な CSS フレームワーク。正直あんまり好みじゃないけど使ってみることになったので設定を入れる。


## lsp-tailwindcss {#lsp-tailwindcss}


### 概要 {#概要}

[lsp-tailwindcss](https://github.com/merrickluo/lsp-tailwindcss) は tailwind の補完をしやすくしてくれたりその実装がどうなっているのか表示してくれたりする便利なやつ


### インストール {#インストール}

el-get 公式に recipe はないので適当に作っている。

```emacs-lisp
(:name lsp-tailwindcss
       :website "https://github.com/merrickluo/lsp-tailwindcss"
       :description "The lsp-mode client for tailwindcss"
       :type github
       :pkgname "merrickluo/lsp-tailwindcss"
       :depends '(f lsp-mode))
```

で `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle lsp-tailwindcss)
```


### 設定 {#設定}

メインの lsp client として動いてもしょうがないので
addon mode として動くようにしている。

```emacs-lisp
(setopt lsp-tailwindcss-add-on-mode t)
```
