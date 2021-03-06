+++
title = "1. 基本設定"
draft = false
+++

## 概要 {#概要}

ここでは org-mode 周りのベースとなる設定を書いているつもり。といいつつ、まだ書き方が雑だなと思っている。またその内にでも修正しよう


## org-mode のインストール {#org-mode-のインストール}

Emacs に標準で入っている org-mode は大体古過ぎるのでとりあえずデフォルトで入ってるやつは削除しちゃって
el-get でインストールしている。

```emacs-lisp
(el-get-bundle org-mode :checkout "release_9.3.6")
```

なんか入れてるパッケージの問題か、依存関係が解決できなかったので
Git から入れた上でバージョンを固定している。

バージョンぐらいはそのうち上げたいね


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
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
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


## Excel ファイルを OS で指定したアプリで開く {#excel-ファイルを-os-で指定したアプリで開く}

org-mode のリンク先の拡張子が xlsx の時に OS 側で指定した標準アプリを開くようにしている。
Excel が入っていたらそっちで開かれるし、入ってなければ Numbers で開かれる。はず。

```emacs-lisp
(with-eval-after-load 'org
  (add-to-list 'org-file-apps '("\\.xlsx?\\'" . default)))
```

第二引数に default を指定すると、内部的には open コマンドが使われることを利用している。
