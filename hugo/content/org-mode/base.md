+++
title = "基本設定"
draft = false
weight = 1
+++

## 概要 {#概要}

ここでは org-mode 周りのベースとなる設定を書いているつもり。といいつつ、まだ書き方が雑だなと思っている。またその内にでも修正しよう


## org-mode のインストール {#org-mode-のインストール}

Emacs に標準で入っている org-mode は古かったりするのでとりあえずデフォルトで入ってるやつは削除しちゃって el-get でインストールしている。

```emacs-lisp
(el-get-bundle org-mode)
```

とりあえず今は Emacs 29.1 に標準で bundle されているバージョンを入れておいている。バージョンを固定するために el-get についているレシピをコピーして書き換えて使っている。

```emacs-lisp
(:name org-mode
       :website "http://orgmode.org/"
       :description "Org-mode is for keeping notes, maintaining ToDo lists, doing project planning, and authoring with a fast and effective plain-text system."
       :type git
       :url "https://git.savannah.gnu.org/git/emacs/org-mode.git"
       :checkout "release_9.6.6"
       :info "doc"
       :build/berkeley-unix `,(mapcar
                               (lambda (target)
                                 (list "gmake" target (concat "EMACS=" (shell-quote-argument el-get-emacs))))
                               '("oldorg"))
       :build `,(mapcar
                 (lambda (target)
                   (list "make" target (concat "EMACS=" (shell-quote-argument el-get-emacs))))
                 '("oldorg"))
       :load-path ("." "lisp")
       :load ("lisp/org-loaddefs.el"))
```

その内もっと新しいのにするけど
<span class="timestamp-wrapper"><span class="timestamp">[2023-10-30 月] </span></span> に main ブランチのものを入れたら agenda が動かなくなって焦ったのでまた落ち着いた時にトライする


## org 用ディレクトリの指定 {#org-用ディレクトリの指定}

org-mode のファイルを保存するデフォルトのディレクトリを指定している。

デフォルトだと `~/org` なのだけどホームディレクトリを汚したくないのと基本的に Mac を使ってるので `~/Documents/org` というディレクトリを用意してそこにファイルを置いている。

```emacs-lisp
(setq org-directory (expand-file-name "~/Documents/org/"))
```


## タスク管理ファイルのフォルダの指定 {#タスク管理ファイルのフォルダの指定}

タスク管理ファイルがいくつかに分かれているがそれらをまとめて `~/Documents/org/tasks` フォルダに置いている。

```emacs-lisp
(setq my/org-tasks-directory (concat org-directory "tasks/"))
```

とりあえずこの `my/org-tasks-directory` という変数を用意することであちらこちらでこれを使い回している。


## タスクの状態管理のキーワード指定 {#タスクの状態管理のキーワード指定}

org-mode といえば TODO 管理で使ってる人も多いと思う。自分も最初はそういう使い方から始めたし、今でもそれをメインにして使っている。

そして TODO の状態がデフォルトでは

-   TODO
-   DONE

の2つしかないけど、それでは足りないので昔見たインターネットのどこかの記事を参考に以下のように設定している。

```emacs-lisp
(setq org-todo-keywords
      '((sequence "TODO" "EXAMINATION(e)" "READY(r)" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
```

初期状態は TODO で、作業開始時点で DOING にして待ちが発生したら WAIT にして完了したら DONE にしている。

SOMEDAY は「いつかやる」に付与しているけど最近ほとんど使ってない。

org-todo-keywords は複数の sequence を指定したり
type を指定したりもできるがそこまでの活用ができていないので、どこかで見直したいですね。


## 完了時間の記録 {#完了時間の記録}

org-clock を使うようにしているしあんまり要らない気がする。もしかしたら habits で必要かもしれないけど。

```emacs-lisp
(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")
```


## タグ設定時の補完候補設定 {#タグ設定時の補完候補設定}

agenda ファイルに使われているタグは全部補完対象になってほしいのでそのように設定している

```emacs-lisp
(custom-set-variables
  '(org-complete-tags-always-offer-all-agenda-tags t))
```


## org-mode 読み込み後の追加実行コード {#org-mode-読み込み後の追加実行コード}

まず org-protocol を使って Firefox と連携したいのでこれを読み込むようにしている。また org-mode のリンク先の拡張子が xlsx の時に OS 側で指定した標準アプリを開くようにしている。

```emacs-lisp
(with-eval-after-load 'org
  (require 'org-protocol)
  (add-to-list 'org-modules 'org-protocol)
  (add-to-list 'org-file-apps '("\\.xlsx?\\'" . default)))
```

第二引数に default を指定すると、内部的には Mac なら open コマンドが使われることを利用している。
