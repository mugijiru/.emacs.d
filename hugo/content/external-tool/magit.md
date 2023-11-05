+++
title = "magit"
draft = false
+++

## 概要 {#概要}

[magit](https://github.com/magit/magit) は Emacs の上で Git の色々な操作ができるやつ。結構使いやすいのでオススメなやつ。

[forge]({{< relref "forge" >}}) を使うと GitHub や GitLab とも連携できてさらに便利、なはず。


## インストール {#インストール}

```emacs-lisp
(el-get-bundle magit)
```


## その他設定 {#その他設定}

ghub を load-path に入れないとうまくいかなかった時があったので load-path に入れてたり、
orgit を入れていたり

```emacs-lisp
(with-eval-after-load 'magit
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/ghub/lisp")))

(el-get-bundle orgit)
```

なお orgit は recipe を自前で用意している

```emacs-lisp
(:name orgit
       :website "https://github.com/magit/orgit"
       :description "Link to Magit buffers from Org documents."
       :type github
       :branch "main"
       :pkgname "magit/orgit"
       :depends (compat magit org-mode))
```

あと ghub は compat に依存するようになったのでとりあえず自前で recipe を用意している

```emacs-lisp
(:name ghub
       :type github
       :description "Minuscule client for the Github API"
       :pkgname "magit/ghub"
       :depends (let-alist treepy compat)
       :branch "main"
       :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.
       :build `(("make" ,(format "EMACSBIN=%s" el-get-emacs) "info"))
       :build/berkeley-unix `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs)
                               "info")))
```


## 使い方 {#使い方}

Git 管理されてるファイルを開いている時に
`M-x magit` とかすると Git 管理用のバッファが出て来るしそこで `?` を叩いたらどういうコマンドが使えるのか教えてくれるよ(雑)
