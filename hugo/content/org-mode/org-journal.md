+++
title = "org-journal"
draft = false
+++

## 概要 {#概要}

[org-journal](https://github.com/bastibe/org-journal) は org-mode で日記を書くためのモードっぽい。

デフォルトに近い設定だと
\`M-x org-journal-new-entry\` でその日の日記ファイルを生成してその時刻を Headline を用意するようになってる。

一度書いた後にまた同じコマンドを叩くと以前に書いた記事を開いて新しい時刻の Headline を用意するのでなんか書きたくなったら雑に書いておくと、時系列順に並んでいくので便利かもしれない。まだ使ってないから本当に便利かは分からない


## インストール {#インストール}

これは el-get にはレシピがないようなので自前で用意している

```emacs-lisp
(:name org-journal
       :website "https://github.com/bastibe/org-journal"
       :description "Functions to maintain a simple personal diary / journal in Emacs."
       :type github
       :pkgname "bastibe/org-journal")
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle org-journal)
```

また [refile 先の候補設定]({{< relref "org-refile#refile-先の候補設定" >}}) で `org-journal--get-entry-path` という内部関数を使ってしまっていてそれが読み込まれていないと困るので、ここで require まで行っている

```emacs-lisp
(require 'org-journal)
```


## 設定 {#設定}

```emacs-lisp
(custom-set-variables
 '(org-journal-dir (concat org-directory "journal/"))
 '(org-journal-file-format "%Y%m%d.org")
 '(org-journal-date-format "%d日(%a)")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-carryover-items "TODO={TODO\\|DOING\\|WAIT}"))
```
