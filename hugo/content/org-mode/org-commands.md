+++
title = "org-mode 用の独自コマンド"
draft = false
weight = 13
+++

## 概要 {#概要}

org-mode を使う上で、標準で用意されているコマンド以外に自分でも適当にコマンドを用意しているのでここにまとめている。


## org-mode 用のファイルを作成するコマンド <span class="tag"><span class="unused">unused</span></span> {#org-mode-用のファイルを作成するコマンド}

指定したフォルダに org-mode なファイルを作るためのコマンドを用意している。

が、使ってないし意味をあまり感じないし消して良さそう。

```emacs-lisp
(setq my/org-document-dir (expand-file-name "~/Documents/org/"))
(defun my/create-org-document ()
  (interactive)
  (find-file-other-window my/org-document-dir))
```


## 各ツリーの所要時間表示/非表示切替 {#各ツリーの所要時間表示-非表示切替}

org-clock-display で各ツリーにおける org-clock で記録された所要時間が表示でき、
org-clock-remove-overlays でそれを非表示にできるが、それを Toggle できるようにコマンド/関数を定義している。

```emacs-lisp
(defun my/org-clock-toggle-display ()
  "各ツリーの末尾に掛かった作業時間を表示/非表示を切り替えるコマンド"
  (interactive)
  (if org-clock-overlays
      (org-clock-remove-overlays)
    (org-clock-display)))
```


## org-todo-keywords から装飾を省いた文字列のリストを返す関数 {#org-todo-keywords-から装飾を省いた文字列のリストを返す関数}

ivy で org-todo-keywords を選択可能にするために
org-todo-keywords を加工してシンプルな文字列の配列にする関数を定義している。

後述の `my/org-todo` で利用している

```emacs-lisp
(defun my/org-todo-keyword-strings ()
  "org-todo-keywords から装飾を省いた文字列のリストを返す関数"
  (let* ((keywords (cl-rest (cl-first org-todo-keywords)))
         (without-delimiter (cl-remove-if (lambda (elm) (string= "|" elm))
                                          keywords)))
    (mapcar (lambda (element)
              (replace-regexp-in-string "\(.+\)" "" element))
            without-delimiter)))
```


## Ivy で TODO ステータスを選択し設定するコマンド {#ivy-で-todo-ステータスを選択し設定するコマンド}

標準の org-todo だと画面がガチャガチャ動くのが気になったので
ivy で選択できるようにしている。

```emacs-lisp
(defun my/org-todo ()
  "ivy で TODO ステータスを切り替えるためのコマンド
Hydra から利用するために定義している。"
  (interactive)
  (ivy-read "Org todo: "
            (my/org-todo-keyword-strings)
            :require-match t
            :sort nil
            :action (lambda (keyword)
                      (org-todo keyword))))
```


## タグ選択でそのタグがついたヘッドラインをリスト表示 {#タグ選択でそのタグがついたヘッドラインをリスト表示}

タグ毎に見たいことがありそうなので用意したやつ。存在を忘れてしまっていたのであまり使ってない。

カスタムアジェンダを頑張る方が良い気もする

```emacs-lisp
(defun my/org-tags-view-only-todo ()
  (interactive)
  (org-tags-view t))
```


## org-gcal で取得した情報を appt に登録 {#org-gcal-で取得した情報を-appt-に登録}

appt.el で通知されるように登録する必要があるのでコマンドを定義している。

```emacs-lisp
(defun my/org-refresh-appt ()
  (interactive)
  (let ((org-agenda-files (append my/org-agenda-calendar-files org-agenda-files)))
    (org-agenda-to-appt t)))
```


## calfw で選択したカレンダーを表示 {#calfw-で選択したカレンダーを表示}

```emacs-lisp
(defun my/open-calendar ()
  (interactive)
  (ivy-read "Calendar: "
            my/calendar-targets
            :require-match t
            :sort nil
            :action (lambda (target)
                      (progn
                        (setq cfw:org-icalendars `(,(concat org-directory target ".org")))
                        (cfw:open-org-calendar)))))
```


## レビュー依頼がされてる PR を取得してバッファに挿入 {#レビュー依頼がされてる-pr-を取得してバッファに挿入}

review-requested-prs というコマンドでレビュー対象の PR を取得できるようにしているのでそれを Emacs から叩けるようにしているコマンド。

```emacs-lisp
(defun my/insert-review-requested-prs-as-string ()
  (interactive)
  (let* ((cmd (concat "review-requested-prs " my/github-organization " " my/github-repository))
         (response (shell-command-to-string cmd)))
    (insert response)))
```

実際のところこの Emacs のコマンドは使わず
Terminal で review-requested-prs というコマンドを直で叩いているから何かしら工夫が必要そうである。

あと、そもそも既にバッファにあるやつとマージしたいとか色々やりたいことはあるのでそれをなんとかしたいですね。
