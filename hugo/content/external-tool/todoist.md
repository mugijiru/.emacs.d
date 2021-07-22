+++
title = "todoist"
draft = false
+++

## 概要 {#概要}

[emacs-todoist](https://github.com/abrochard/emacs-todoist) は Todo 管理サービスである Todoist と連携するためのパッケージ。
org-mode に依存している。


## インストール {#インストール}

```emacs-lisp
(el-get-bundle  abrochard/emacs-todoist)
```


## 設定 {#設定}

API キーを設定するので別ファイルに分離している。いつか .authinfo.gpg に移動しようかなと思っているけどそもそも最近 TODOIST 使ってない……

```emacs-lisp
(with-eval-after-load 'org
  (my/load-config "my-todoist-config"))
```
