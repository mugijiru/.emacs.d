+++
title = "org-refile"
draft = false
weight = 10
+++

## 概要 {#概要}

org-refile は org-mode の1機能で
org-mode のエントリを別のファイルなどに移動するための機能。実はコピーもできるけど、コピーは使ったことがない。


## 設定 {#設定}


### org ファイル内の階層を選択候補に入れる {#org-ファイル内の階層を選択候補に入れる}

これを nil に設定することでファイルの選択だけでなく、その中の PATH まで選択できるようになる

```emacs-lisp
(setq org-outline-path-complete-in-steps nil)
```


### refile ターゲットにファイル名を含める {#refile-ターゲットにファイル名を含める}

以下のように設定すると
refile のターゲット候補としてファイル名とその中の PATH が表示されるようになる。

```emacs-lisp
(setq org-refile-use-outline-path 'file)
```

nil だと移動先候補PATHの最後の部分しか表示されないのでどのファイルのどの場所かというのがわかりにくいのでこのように設定している。


### refile 先の候補設定 {#refile-先の候補設定}

いくつかの org ファイルを使っているのでターゲットを以下のように設定している。

```emacs-lisp
(setq org-refile-targets `((,(org-journal--get-entry-path) :regexp . "Tasks")
                           (,(concat org-directory "tasks/projects.org") :level . 1)
                           (,(concat org-directory "tasks/pointers.org") :level . 1)
                           (,(concat org-directory "work/scrum/impediments.org") :level . 3)
                           (,(concat org-directory "private/2020_summary.org") :level . 2)
                           (,(concat org-directory "tasks/shopping.org") :level . 1)
                           (,(concat org-directory "tasks/someday.org") :level . 1)))
```

| ターゲット         | 目的                                                             |
|---------------|----------------------------------------------------------------|
| projects.org       | とりあえずその内やるタスクを放り込むところ。Work, Private の階層を設けているので `:level 2` としている |
| pointers.org       | 読物を突っ込むところとしている。                                 |
| impediments.org    | スクラムの妨害リストでも作ってみようかと思って用意したやつ。放置中 |
| next-actions today | その日やる作業を放り込むところ。projects や inbox から移動する時に使う。 |
| next-actions C-    | いくつかの作業を各階層に分けて管理しようとしていたのでターゲット指定している。放置中。 |
| 2020_summary.org   | 2020 年の個人ふりかえり用。もう 2020 年は大昔なので当然もう使っていない |
| shopping.org       | 買物リスト。時々思い出した時に放り込んでるが主に使うのは beorg からなので refile では使ってない |
| someday.org        | 遠い将来やるかもしれないリスト。放り込んで忘れるためにあるところ |
