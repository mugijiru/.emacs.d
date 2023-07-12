+++
title = "projectile"
draft = false
+++

## 概要 {#概要}

[projectile](https://github.com/bbatsov/projectile) はプロジェクト内のファイルを検索したりするのに便利なパッケージ


## インストール {#インストール}

いつも通り el-get からインストールする

```emacs-lisp
(el-get-bundle projectile)
```


## 有効化 {#有効化}

このあたりで有効化しておいている。この順序に意味があったかは忘れた……。

```emacs-lisp
(projectile-mode)
```


## 無視リスト {#無視リスト}

普段 Rails ばっかりやってるのでそれ関係のものを無視リストに入れている。けどあんまりメンテしてない。


### 無視するディレクトリ {#無視するディレクトリ}

```emacs-lisp
(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories ".tmp")
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories ".sass-cache")
(add-to-list 'projectile-globally-ignored-directories "coverage")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "log")
```

node_modules もここに突っ込んでも良いかもしれない。


### 無視するファイル {#無視するファイル}

```emacs-lisp
(add-to-list 'projectile-globally-ignored-files "gems.tags")
(add-to-list 'projectile-globally-ignored-files "project.tags")
(add-to-list 'projectile-globally-ignored-files "manifest.json")
```

tags ファイルは昔は使っていたけど、最近は dumb-jump が優秀なのと、面倒で使ってないのでそろそろ gems.tags と project.tags は不要かもしれない。


## ivy/counsel との連携 {#ivy-counsel-との連携}

上の方で helm との連携処理を入れていたが今は大体 ivy に乗り換えているので ivy 連携もしている。

```emacs-lisp
(setq projectile-completion-system 'ivy)
(el-get-bundle counsel-projectile)
```

counsel-projectile はいくつかの絞り込み処理を提供してくれて便利。それでも足りなかったら自前で何か作ることになるのかなと思っている。


## キーバインド {#キーバインド}

デフォルトでいくつかのキーバインドが用意されてるようだけどそんなものさっぱり覚えられないのでとりあえずいくつかを Hydra で叩けるようにしている

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    projectile-hydra (:separator "-" :title "Projectile" :foreign-key warn :quit-key "q" :exit t)
    ("File"
     (("f" counsel-projectile-find-file "Find File")
      ("d" counsel-projectile-find-dir "Find Dir")
      ("r" projectile-recentf "Recentf"))

     "Edit"
     (("R" projectile-replace "Replace"))

     "Other"
     (("p" (counsel-projectile-switch-project 'neotree-dir) "Switch Project")))))
```

| Key | 効果                    |
|-----|-----------------------|
| f   | プロジェクト内のファイルを検索 |
| d   | プロジェクト内のフォルダを検索 |
| r   | プロジェクト内で最近触ったファイルのリスト表示 |
| p   | 別のプロジェクトに切り替え |

-   `projectile-find-implementation-or-test`
-   `projectile-replace`
-   `projectile-replace-regxp`

あたりも使えるようにするともしかしたら便利かもしれない。あとは `counsel-projectile-grep` とかの類か。


## その他 {#その他}

基本的に Rails のプロジェクトをやっているので
projectile-rails をベースにいつも触ってるので projectile そのものはあまり弄ってないのであった
