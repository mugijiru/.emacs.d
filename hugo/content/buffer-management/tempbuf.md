+++
title = "tempbuf"
draft = false
+++

## 概要 {#概要}

[tempbuf-mode](https://www.emacswiki.org/emacs/TempbufMode) は不要になったと思われるバッファを自動的に kill してくれるパッケージ。使っていた時間が長い程、裏に回った時には長い時間保持してくれる。

つまり、一瞬開いただけのファイルは明示的に kill しなくても勝手にやってくれるのでファイルを開いてそのまま放置みたいなことをしがちなズボラな人間には便利なやつ。


## インストール {#インストール}

いつも通り el-get で入れている。

```emacs-lisp
(el-get-bundle tempbuf-mode)
```


## 勝手に kill させないファイルの指定 {#勝手に-kill-させないファイルの指定}

org-clock を使うようなファイルは
kill されると org-clock が狂って面倒なことになるのでそれらのファイルは勝手に kill されないように ignore リストに突っ込んでいる

```emacs-lisp
(setq my/tempbuf-ignore-files '("~/Documents/org/tasks/reviews.org"
                                "~/Documents/org/tasks/interrupted.org"
                                "~/Documents/org/tasks/next-actions.org"
                                ))
```


## find-file への hook {#find-file-への-hook}

find-file した時に上でリストアップしたファイルだった場合は kill されないように
tempbuf-mode が自動的に無効になるような hook を用意している。

```emacs-lisp
(defun my/find-file-tempbuf-hook ()
  (let ((ignore-file-names (mapcar 'expand-file-name my/tempbuf-ignore-files)))
    (unless (member (buffer-file-name) ignore-file-names)
      (turn-on-tempbuf-mode))))
```


## hook の設定 {#hook-の設定}

find-file では上で作成した hook を使うことで
kill されたくないファイルは kill されないようにしている

```emacs-lisp
(add-hook 'find-file-hook 'my/find-file-tempbuf-hook)
```

また dired buffer も邪魔になりがちだけど、デフォルトだと対象にならないのでこいつらも tempbuf-mode の管理対象となるように tempbuf-mode を有効にしている。

```emacs-lisp
(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
```


## その他 {#その他}

[midnight-mode](https://www.emacswiki.org/emacs/MidnightMode) という、深夜に処理を実行させるようなやつで夜間にバッファをごっそり消すみたいなことをしている人も結構いるっぽい。
