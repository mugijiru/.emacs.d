+++
title = "日報用の設定(旧)"
tags = ["unused"]
draft = false
weight = 15
+++

## 概要 {#概要}

業務で日報を提出する必要があったのでそれっぽいのを作れるようにしていた。

今では org-super-agenda を使っているのでこれは使ってないが、とりあえず載せておく。


## シークレット設定の読み込み {#シークレット設定の読み込み}

表に出したくない情報については別ファイルに分離して setq している。が、内容的に本名が露出する程度の情報ではある。

```emacs-lisp
(my/load-config "my-nippou-config")
```

これの中で `my/org-nippou-additional-files` を定義していてそのファイル名に名前が含まれてるだけであった。

`me.org` とでもしておけば解決しそう……。


## 日報構築の対象となるファイルをリストアップする関数の定義 {#日報構築の対象となるファイルをリストアップする関数の定義}

`~/Documenets/org/tasks` に作業記録用ファイルなどを find コマンドを使ってリストアップする関数。

```emacs-lisp
(defun my/org-nippou-files ()
  (let* ((dir my/org-tasks-directory)
         (cmd (format "find \"%s\" -name '*.org' -or -name '*.org_archive'" dir))
         (result (shell-command-to-string cmd))
         (file-names (split-string result "\n")))
    (-remove (lambda (file-name) (string= "" file-name))
             file-names)))
```

org-agenda-files を使えば要らないっぽいけどね。
agenda 全然使えてなかったらこんなことに。


## 日報構築元ファイルを取得する関数の定義 {#日報構築元ファイルを取得する関数の定義}

シークレット設定で定義した変数と上で定義した `my/org-nippou-files` を結合して
1つのリストにするだけの関数を用意している。
1つにまとまってる方が扱いやすいので。

```emacs-lisp
(defun my/org-nippou-targets ()
      (-concat (my/org-nippou-files) my/org-nippou-additional-files))
```


## 日報を出力する関数 {#日報を出力する関数}

上記の関数群で target になるファイルから日報用に TODO 項目を引っ張り出してくる関数を用意している。

```emacs-lisp
(defun my/nippou-query ()
  (interactive)
  (org-ql-search
    (my/org-nippou-targets)
    "todo:TODO,DOING,WAIT,DONE ts:on=today"
    :title "日報"
    :super-groups '((:auto-group))))
```

その中では [org-ql](https://github.com/alphapapa/org-ql) の org-ql-search という関数を叩いている。
org-ql は使いこなすと色々なことができそうではあるがそれを内部で使ってる [org-super-agenda](https://github.com/alphapapa/org-super-agenda) を使えば十分な感じではある。
