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


## agenda のスコープ設定用関数 {#agenda-のスコープ設定用関数}

org-clock-report では前日分も target に入れてほしいのでそれの `:scope` に指定するための関数を自前で用意している

```emacs-lisp
(defun my/org-agenda-scope-with-yesterday-journal ()
  (let* ((agenda-files (org-agenda-files t))
         (24-hours-ago (* -60 60 24))
         (yesterday (time-add (current-time) 24-hours-ago))
         (yesterday-string (format-time-string "%Y%m%d" yesterday))
         (yesterday-journal-file-path (concat org-journal-dir yesterday-string ".org"))
         (today-journal-file-path (org-journal--get-entry-path))
         (files (append `(,yesterday-journal-file-path ,today-journal-file-path) agenda-files)))
    (org-add-archive-files files)))
```


## 設定 {#設定}

```emacs-lisp
(setopt org-journal-dir (concat org-roam-directory "journal/"))
(setopt org-journal-file-format "%Y%m%d.org")
(setopt org-journal-date-format "%d日(%a)")
(setopt org-journal-enable-agenda-integration nil)
(setopt org-journal-carryover-items "TODO={TODO\\|DOING\\|WAIT}")
```


## hook {#hook}

org-journal ファイルを新しく作る度にそのファイルを refile target で扱って欲しいのと
org-agenda-files も同様に扱って欲しいので
hook でそれらを設定し直すようにしている

```emacs-lisp
(defun my/org-journal-mode-hooks ()
  "Set org-journal mode hooks."
  (my/reset-org-agenda-files)
  (my/reset-org-refile-targets))

(with-eval-after-load 'org-journal
  (add-to-list 'org-journal-after-header-create-hook 'my/org-journal-mode-hooks))
```
