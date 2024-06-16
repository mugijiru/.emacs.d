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
    ("Find"
     (("f" counsel-projectile-find-file "Find File")
      ("d" counsel-projectile-find-dir "Find Dir")
      ("r" projectile-recentf "Recentf"))

     "Jump"
     (("l" projectile-edit-dir-locals "dir-locals"))

     "Edit"
     (("R" projectile-replace "Replace"))

     "Other"
     (("p" (counsel-projectile-switch-project 'counsel-projectile-switch-project-action-vc) "Switch Project")
      ("SPC" my/project-hydra "Hydra")))))
```

| Key | 効果                    |
|-----|-----------------------|
| f   | プロジェクト内のファイルを検索 |
| d   | プロジェクト内のフォルダを検索 |
| r   | プロジェクト内で最近触ったファイルのリスト表示 |
| l   | .dir-locals.el を開く   |
| E   | 一括置換する            |
| p   | 別のプロジェクトに切り替え |
| SPC | プロジェクト固有の Hydra を起動する |

-   `projectile-find-implementation-or-test`
-   `projectile-replace-regexp`

あたりも使えるようにするともしかしたら便利かもしれない。あとは `counsel-projectile-grep` とかの類かな〜


## projectile 用のコマンド/ヘルパー関数 {#projectile-用のコマンド-ヘルパー関数}


### プロジェクト固有の Hydra 呼び出し {#プロジェクト固有の-hydra-呼び出し}

プロジェクト固有の Hydra を `{project-dir-name}-hydra` のように定義しておけばプロジェクトのディレクトリ名を用いてそれ用の Hydra を呼び出す関数。

プロジェクト固有の Hydra は .dir-locals で定義することを念頭に置いているが、
Emacs の設定ファイルに直接埋め込んでいても特に問題はないはず。

```emacs-lisp
(defun my/project-hydra ()
  "Call the project specific hydra."
  (interactive)
  (let* ((project-path (directory-file-name (projectile-acquire-root)))
         (project-dir-name (file-name-base project-path))
         (hydra-body (intern (concat project-dir-name "-hydra/body"))))
    (cond
     ((fboundp hydra-body)
      (funcall hydra-body))
     (t
      (user-error "project hydra is not defined on %s." project-dir-name)))))
```


### プロジェクト内のファイルを開く {#プロジェクト内のファイルを開く}

プロジェクト内に1つしかないようなファイルは completing-read で絞り込む必要がないのでぱぱっと開けるようにするためのコマンドを用意した。

```emacs-lisp
(defun my/projectile-goto-file (file-path)
  "Go to the file path"
  (let ((path (concat (projectile-acquire-root) file-path)))
    (cond
     ((file-exists-p path)
      (find-file path))
     (t
      (user-error "%s is not found." file-path)))))
```


### プロジェクト内の指定フォルダのファイルを検索 {#プロジェクト内の指定フォルダのファイルを検索}

実装ファイルなどは特定のフォルダ以下に複数存在するのが一般形なので指定したフォルダ以下のファイルを completing-read で絞り込めるようにしている。

```emacs-lisp
(defun my/projectile-find-file-in-dir (dir-path)
  "Find the file path"
  (interactive)
  (let ((path (concat (projectile-acquire-root) dir-path)))
    (cond
     ((and (file-exists-p path) (file-directory-p path))
      (projectile-find-file-in-directory path))
     (t
      (user-error "%s is not directory." dir-path)))))
```


### Dockerfile を開く {#dockerfile-を開く}

今時は Docker がよく使われているので Dockerfile を開くコマンドを用意した。

```emacs-lisp
(defun my/projectile-goto-dockerfile ()
  "Find the Dockerfile"
  (interactive)
  (my/projectile-goto-file "Dockerfile"))
```


### .circleci/config.yml を開く {#dot-circleci-config-dot-yml-を開く}

`.circleci/config.yml` も時々開くよねってことで追加した

```emacs-lisp
(defun my/projectile-goto-circleci-config ()
  "Find the CircleCI config.yml"
  (interactive)
  (my/projectile-goto-file ".circleci/config.yml"))
```


### Gemfile を開く {#gemfile-を開く}

Ruby 書いているとお馴染の Gemfile もぱぱっと開きたいので追加

```emacs-lisp
(defun my/projectile-goto-gemfile ()
  "Find the Gemfile"
  (interactive)
  (my/projectile-goto-file "Gemfile"))
```


### .rubocop.yml を開く {#dot-rubocop-dot-yml-を開く}

Ruby 書いていたら大体 rubocop も使うので追加

```emacs-lisp
(defun my/projectile-goto-rubocop-config ()
  "Find the .rubocop.yml"
  (interactive)
  (my/projectile-goto-file ".rubocop.yml"))
```
