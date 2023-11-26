+++
title = "org-roam"
draft = false
+++

## 概要 {#概要}

[org-roam](https://www.orgroam.com/) は記事同士のリンク周りを強化して、検索機能を提供したり繋がりを可視化したりしてくれるやつ。繋がりを可視化することでアイデア同士の結び付きを見つけたりとかに使えるっぽい

内部的には SQLite を使ってリンクを cache しているっぽい。


## インストール {#インストール}

el-get 本体ではレシピを提供していないのでとりあえず自前で用意している

```emacs-lisp
(:name org-roam
       :website "https://www.orgroam.com/"
       :description "A plain-text knowledge management system."
       :type github
       :branch "main"
       :pkgname "org-roam/org-roam"
       :depends (dash emacsql magit org-mode))
```

そしてそれを `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle org-roam)
```


## 設定 {#設定}

既存の org ファイル全てを対象にすると最初の DB 構築で無限に時間がかかるので
org フォルダの下に roam というフォルダを掘ってその中だけを対象としている

```emacs-lisp
(custom-set-variables
 '(org-roam-directory (file-truename (concat org-directory "roam/"))))
```

そして自動的に SQLite3 と同期するように自動同期の設定を入れている

```emacs-lisp
(org-roam-db-autosync-mode 1)
```


## キーバインド {#キーバインド}

とりあえず忘れても使えるように pretty-hydra で操作できるように設定している

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    org-roam-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-material "graphic_eq") " Roam")
                :quit-key "q")
    ("Node"
     (("f" org-roam-node-find "Find")
      ("r" org-roam-node-random "Random"))

     "DB"
     (("S" org-roam-db-sync "Sync")
      ("C" org-roam-db-clear-all "Clear")))))
```
