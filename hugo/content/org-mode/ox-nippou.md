+++
title = "ox-nippou"
draft = false
+++

## 概要 {#概要}

[ox-nippou](https://github.com/mugijiru/ox-nippou) は org-mode のファイルから日報を出力するための自作パッケージです。


## インストール {#インストール}

自作パッケージなので自前で el-get 用にレシピを用意している

```emacs-lisp
( :name ox-nippou
  :website "https://github.com/mugijiru/ox-nippou"
  :description "ox-nippou is a tool for generating daily reports from Org-mode files."
  :type github
  :pkgname "mugijiru/ox-nippou"
  :depends (org-mode markdown-mode)
  :branch "main")
```

そしてそれを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle ox-nippou)
```


## カスタマイズ {#カスタマイズ}

-   変換元ファイルの格納先の指定
-   対象タスクがない時の表示
-   TODO state と日報との対応

をカスタム変数で設定している

```emacs-lisp
(setopt ox-nippou-journal-directory (expand-file-name "journal" org-roam-directory))
(setopt ox-nippou-no-tasks-string ":pear:")
(setopt ox-nippou-todo-state-mapping '(("todo" . ("TODO"))
                                       ("doing" . ("DOING" "WAIT"))
                                       ("done" . ("DONE"))))
```
