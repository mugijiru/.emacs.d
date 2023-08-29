+++
title = "emacs-kibela"
draft = false
+++

## 概要 {#概要}

[emacs-kibela](https://github.com/mugijiru/emacs-kibela/) は Emacs で Kibela を操作するための自作のパッケージ。あまり機能は実装されていないけど、テンプレートから記事を書いたりする程度のことはできる


## インストール {#インストール}

MELPA には登録してないし el-get にもレシピを登録していないので自前で el-get の recipe を用意している

```emacs-lisp
(:name emacs-kibela
       :website "https://github.com/mugijiru/emacs-kibela"
       :description "Kibela client."
       :type github
       :branch "main"
       :pkgname "mugijiru/emacs-kibela"
       :depends (graphql request markdown-mode))
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle emacs-kibela)
```


## 設定 {#設定}

.authinfo.gpg に認証情報を突っ込んでいるのでそこから認証情報を拾って来て set している

```emacs-lisp
(custom-set-variables
 '(kibela-auth-list `(("Work"
                        ,(plist-get (nth 0 (auth-source-search :host "emacs-kibela-work")) :team)
                        ,(funcall (plist-get (nth 0 (auth-source-search :host "emacs-kibela-work" :max 1)) :secret)))
                       ("Private"
                        ,(plist-get (nth 0 (auth-source-search :host "emacs-kibela-private")) :team)
                        ,(funcall (plist-get (nth 0 (auth-source-search :host "emacs-kibela-private" :max 1)) :secret))))))
```


## 自前の関数 {#自前の関数}

[ivy-kibela](https://github.com/mugijiru/ivy-kibela/) と連携して、最近投稿された記事を Emacs の中で開くためのコマンドを用意している。

もしかしたら emacs-kibela か ivy-kibela のどちらかで
featurep を使って有効無効を切り分けて実装すべきかも

```emacs-lisp
(defun my/kibela-show-recent-note ()
  "最近投稿された記事を見るためのコマンド
ivy-kibela-recent で最近投稿された記事を拾って
kibela-note-show でバッファを開く"
  (interactive)
  (ivy-kibela-recent (lambda (title)
                     (let ((id (get-text-property 0 'id title)))
                       (if id
                           (kibela-note-show id))))))
```


## キーバインド {#キーバインド}

各コマンドは Hydra で起動するように設定している。しれっと ivy-kibela のコマンドも混ぜちゃってるけど、使う分にはこの方がやりやすい。

```emacs-lisp
(pretty-hydra-define kibela-hydra (:separator "-" :title "Kibela" :foreign-key warn :quit-key "q" :exit t)
  ("ivy"
   (("r" ivy-kibela-recent "Recent")
    ("R" ivy-kibela-recent-browsing-notes "Recent brwosing notes")
    ("S" ivy-kibela-search "Search"))
   "Group"
   (("g" kibela-group-notes "notes"))
   "Note"
   (("n" kibela-note-new "New")
    ("s" my/kibela-show-recent-note "Show")
    ("t" kibela-note-new-from-template "From template"))
   "Team"
   (("x" kibela-switch-team "Swtich"))))
```
