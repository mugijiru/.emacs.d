+++
title = "org-babel"
draft = false
weight = 2
+++

## 概要 {#概要}

ここでは org-babel の設定をまとめている。


## org-babel のプラグイン追加 {#org-babel-のプラグイン追加}

言語によってはデフォルトでは提供されていないのでプラグインを追加する


### ob-graphql {#ob-graphql}

レシピは el-get 本体にはないので自前で用意。

```emacs-lisp
(:name ob-graphql
       :website "https://github.com/jdormit/ob-graphql"
       :description "GraphQL execution backend for org-babel."
       :type github
       :branch "master"
       :pkgname "jdormit/ob-graphql"
       :depends (graphql-mode request))
```

そしていつも通り `el-get-bundle` でインストール。

```emacs-lisp
(el-get-bundle ob-graphql)
```


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
                               (org . t)
                               (graphql . t)
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


## org-babel-execute 後に画像を再表示 {#org-babel-execute-後に画像を再表示}

PlantUML の処理をすることが多いので以下の hook を設定することで実行後に画像を再表示するようにしている

```emacs-lisp
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
```


## org-babel の非同期実行 <span class="tag"><span class="improvement">improvement</span></span> {#org-babel-の非同期実行}

非同期に org-babel の source を実行するために
[ob-async](https://github.com/astahlman/ob-async) を入れている

レシピは自前で用意している

```emacs-lisp
(:name ob-async
       :description "Asynchronous org-babel src block execution"
       :type github
       :pkgname "astahlman/ob-async"
       :depends (emacs-async org-mode dash)
       :minimum-emacs-version (24 4))
```

そして `el-get-bundle` でインストール。

```emacs-lisp
(el-get-bundle ob-async)
(require 'ob-async)
```

で、ob-async を何のために入れているかというと PlantUML の図の出力である。画像まで作成するからね、時間かかりそうだしね。

そんで、その時に `org-plantuml-jar-path` を強制的に指定している。

```emacs-lisp
(add-hook 'ob-async-pre-execute-src-block-hook
          '(lambda ()
             (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
```

多分 custom-set-variables でちゃんと設定したらいいんだろうなあ。


## カスタム変数の設定 {#カスタム変数の設定}

`org-id-link-to-org-use-id` を `t` にしていると
`org-store-link` を実行した時に自動で id を発行してそれを store してくれるようになる

また archive ファイルを同じフォルダに `archives` フォルダを掘ってそこに格納したいので org-archive-location を設定している

```emacs-lisp
(custom-set-variables
 '(org-id-link-to-org-use-id t)
 '(org-archive-location "./archives/%s_archive::"))
```


## habit 完了時に Appt を refresh {#habit-完了時に-appt-を-refresh}

Appt + alert.el + Dunst で通知を行っているが、完了後も通知対象として残っていると困るので完了時に refresh するように調整している

```emacs-lisp
(defun my/org-refresh-appt-on-complete-habit (args)
  "習慣タスクを完了した時に Appt を refresh する"
  (let* ((element (org-element-at-point))
         (style (org-element-property :STYLE element))
         (to (plist-get args :to)))
    (if (and (string= style "habit") (string= "TODO" to))
        (my/org-refresh-appt))))

(add-hook 'org-trigger-hook 'my/org-refresh-appt-on-complete-habit)
```


## org-mode-map の override {#org-mode-map-の-override}

windmove-mode とキーバインドがかぶってるのでそれと同居できるように override している。

具体的には org-mode のコマンドが動く場所であればそれを実行しそれがないなら windmove のコマンドを実行する

また org-read-date はデフォルトでシフト+カーソルキーで日付を選択できるが、
windmove にそれを奪われてしまうので、カーソルキー単体でカレンダー選択ができるようにしている。

```emacs-lisp
(defun my/org-mode-map-override-windmove-mode-map ()
  (let ((oldmap windmove-mode-map)
        (newmap (make-sparse-keymap)))
    (make-local-variable 'minor-mode-overriding-map-alist)
    (add-to-list 'minor-mode-overriding-map-alist `(windmove-mode . ,newmap))

    (add-hook 'org-shiftup-final-hook 'windmove-up)
    (add-hook 'org-shiftleft-final-hook 'windmove-left)
    (add-hook 'org-shiftdown-final-hook 'windmove-down)
    (add-hook 'org-shiftright-final-hook 'windmove-right)))

(defun my/org-mode-hook ()
  (my/org-mode-map-override-windmove-mode-map)

  (define-key org-mode-map [remap org-set-tags-command] #'counsel-org-tag)

  ;; http://yitang.uk/2022/07/05/move-between-window-using-builtin-package/
  (define-key org-read-date-minibuffer-local-map (kbd "<left>") (lambda () (interactive) (org-eval-in-calendar '(calendar-backward-day 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<right>") (lambda () (interactive) (org-eval-in-calendar '(calendar-forward-day 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<up>") (lambda () (interactive) (org-eval-in-calendar '(calendar-backward-week 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<down>") (lambda () (interactive) (org-eval-in-calendar '(calendar-forward-week 1)))))

(add-hook 'org-mode-hook 'my/org-mode-hook)

(with-eval-after-load 'org-mode
  (my/org-mode-map-override-windmove-mode-map))
```


## org-src の設定 {#org-src-の設定}

関数内とかで分割して `init.org` に書いた時にデフォルト設定だとインデントが消失してしまって不便なのでコードブロック内のインデントがそのまま反映されるように `org-src-preserve-indentation` を有効にして、さらにコードブロック内で自動で2文字下げられるとまあ面倒なので
`org-edit-src-content-indentation` を 0 に設定している

```emacs-lisp
(custom-set-variables
 '(org-src-preserve-indentation t)
 '(org-edit-src-content-indentation 0))
```
