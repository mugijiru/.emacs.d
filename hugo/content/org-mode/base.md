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


## org-export-blocks-format-plantuml {#org-export-blocks-format-plantuml}

org-mode で PlantUML の図を出力する拡張を入れている。

```emacs-lisp
(el-get-bundle org-export-blocks-format-plantuml)
```

のだけれど
<https://www.emacswiki.org/emacs/org-export-blocks-format-plantuml.el>
を見ると Obsolute と書いてますね。今度消さなきゃ。


## org-babel で評価可能な言語の指定 {#org-babel-で評価可能な言語の指定}

なんか普段から使いそうな奴をとりあえず選定しているつもり。

```emacs-lisp
(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (sql . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (js . t)
                               (ruby . t)))
```

js, ruby
: 仕事でメインで使ってる言語なので入れている。

shell
: 入れてる方が便利そう、ぐらいの雑な理由。

sql
: メモしておいて手元から実行できると便利そう

plantuml
: 図の出力。一番使ってる。

gnuplot
: 趣味で入れてみているけど実際使う機会ほとんどないよなって気がしてきている。


## org 用ディレクトリの指定 {#org-用ディレクトリの指定}

org-mode のファイルを保存するデフォルトのディレクトリを指定している。

デフォルトだと `~/org` なのだけどホームディレクトリを汚したくないのと基本的に Mac を使ってるので `~/Documents/org` というディレクトリを用意してそこにファイルを置いている。

```emacs-lisp
(setq org-directory (expand-file-name "~/Documents/org/"))
```


## Excel ファイルを OS で指定したアプリで開く {#excel-ファイルを-os-で指定したアプリで開く}

org-mode のリンク先の拡張子が xlsx の時に OS 側で指定した標準アプリを開くようにしている。
Excel が入っていたらそっちで開かれるし、入ってなければ Numbers で開かれる。はず。

```emacs-lisp
(add-to-list 'org-file-apps '("\\.xlsx?\\'" . default))
```

第二引数に default を指定すると、内部的には open コマンドが使われることを利用している。


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


## タスク管理ファイルのフォルダの指定 {#タスク管理ファイルのフォルダの指定}

タスク管理ファイルがいくつかに分かれているがそれらをまとめて `~/Documents/org/tasks` フォルダに置いている。

```emacs-lisp
(setq my/org-tasks-directory (concat org-directory "tasks/"))
```

とりあえずこの `my/org-tasks-directory` という変数を用意することであちらこちらでこれを使い回している。


## org-babel の非同期実行 {#org-babel-の非同期実行}

非同期に org-babel の source を実行するために
[ob-async](https://github.com/astahlman/ob-async) を入れている

```emacs-lisp
;; ob-async
(el-get-bundle ob-async)
(require 'ob-async)
```

で、ob-async で何のために入れているかというと PlantUML の図の出力である。画像まで作成するからね、時間かかりそうだしね。

そんで、その時に `org-plantuml-jar-path` を強制的に指定している。

```emacs-lisp
(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
```

多分 custom-set-variables でちゃんと設定したらいいんだろうなあ。


## org-babel-execute 後に画像を再表示 {#org-babel-execute-後に画像を再表示}

PlantUML の処理をすることが多いので以下の hook を設定することで実行後に画像を再表示するようにしている

```emacs-lisp
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
```
