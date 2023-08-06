+++
title = "dashboard"
draft = false
+++

## 概要 {#概要}

[emacs-dashboard](https://github.com/emacs-dashboard/emacs-dashboard) は
Emacs の起動時に色々な情報を表示してくれるパッケージ。


## インストール {#インストール}

el-get のレシピは自前で用意している

```emacs-lisp
(:name dashboard
  :type github
  :description "A startup screen extracted from Spacemacs"
  :pkgname "emacs-dashboard/emacs-dashboard"
  :depends (page-break-lines)
  :minimum-emacs-version (25 3))
```

そして `el-get-bundle` で入れている

```emacs-lisp
(el-get-bundle dashboard)
```


## 表示するアイコンをロゴに変更 {#表示するアイコンをロゴに変更}

ロゴ、画像にした方がカッコいいよねってことで logo に変更している

```emacs-lisp
(setq dashboard-startup-banner 'logo)
```

なお CUI で起動すると自動でテキストでの表示になる


## 表示する情報の設定 {#表示する情報の設定}

dashboard-items を弄ることで表示する情報を設定している

```emacs-lisp
(setq dashboard-items '((recents  . 5)
                        ;; (bookmarks . 5) ;; bookmarks は使ってない
                        (projects . 5)
                        (agenda . 5)
                        ;; (registers . 5) ;; registers は使ってない
                        ))
```

Emacs の bookmarks と register は使ってない(使えてない)のでコメントアウトしている。

あとは最近開いたファイルとプロジェクトとagendaを表示するようにしているがイマイチ活用できてないので色々設定を詰める必要がありそう


## 各セクションのタイトル部の先頭にアイコンを表示 {#各セクションのタイトル部の先頭にアイコンを表示}

これは見た目をちょっとだけカッコよくするために all-the-icons で装飾するための設定

```emacs-lisp
(setq dashboard-set-heading-icons t)
```


## 各ファイルの先頭にアイコンを表示 {#各ファイルの先頭にアイコンを表示}

これも見た目をちょっとだエカッコよくするために all-the-icons で装飾するための設定。だけどファイルの種類がアイコンでわかるので便利。

```emacs-lisp
(setq dashboard-set-file-icons t)
```


## 最後に設定を反映 {#最後に設定を反映}

多分設定を反映するための関数だと思ってる。

```emacs-lisp
(dashboard-setup-startup-hook)
```


## その他 {#その他}

agenda などは表示する内容を絞ったりした方が dashboard として使い勝手が良さそう。今日の会議何があるとかが出ると便利かもね。
