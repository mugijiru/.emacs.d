+++
title = "todoist"
draft = false
+++

## 概要 {#概要}

[emacs-todoist](https://github.com/abrochard/emacs-todoist) は Todo 管理サービスである Todoist と連携するためのパッケージ。
org-mode に依存している。


## インストール {#インストール}

まず以下のレシピを用意している

```emacs-lisp
(:name emacs-todoist
       :website "https://github.com/abrochard/emacs-todoist"
       :description "Emacs interface to Todoist"
       :type github
       :pkgname "abrochard/emacs-todoist")
```

その上で以下のようにしてインストールしている

```emacs-lisp
(el-get-bundle emacs-todoist)
```


## 設定 {#設定}

API キーを設定するので別ファイルに分離している。いつか .authinfo.gpg に移動しようかなと思っているけどそもそも最近 TODOIST 使ってない……

```emacs-lisp
(with-eval-after-load 'todoist
  (setq todoist-token (funcall (plist-get (nth 0 (auth-source-search :host "todoist.com" :max 1)) :secret))))
```
