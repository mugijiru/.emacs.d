+++
title = "magit"
draft = false
+++

## 概要 {#概要}

[magit](https://github.com/magit/magit) は Emacs の上で Git の色々な操作ができるやつ。結構使いやすいのでオススメなやつ。

[forge]({{< relref "forge" >}}) を使うと GitHub や GitLab とも連携できてさらに便利、なはず。


## インストール {#インストール}

レシピは el-get 本体付属のものをコピーして使ってる。
magit の依存関係に変更があったのでそれに追従するため

ref: <https://github.com/mugijiru/.emacs.d/pull/2992>

```emacs-lisp
(:name magit
       :website "https://github.com/magit/magit#readme"
       :description "It's Magit! An Emacs mode for Git."
       :type github
       :pkgname "magit/magit"
       :branch "main"
       :minimum-emacs-version "25.1"
       ;; Note: `git-commit' is shipped with `magit' code itself.
       ;; Note: `magit-section' is shipped with `magit' code itself.
       :depends (dash transient with-editor compat seq)
       :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.  Create an
       ;; empty autoloads file because magit.el explicitly checks for
       ;; a file of that name.
       :build `(("make" ,(format "EMACSBIN=%s" el-get-emacs) "docs")
                ("touch" "lisp/magit-autoloads.el"))
       :build/berkeley-unix `(("gmake" ,(format "EMACSBIN=%s" el-get-emacs) "docs")
                              ("touch" "lisp/magit-autoloads.el"))
       ;; assume windows lacks make and makeinfo
       :build/windows-nt (with-temp-file "lisp/magit-autoloads.el" nil))
```

また依存している `with-editor` や `seq` のレシピも用意している

```emacs-lisp
(:name with-editor
       :description "Use the Emacsclient as $EDITOR"
       :type github
       :pkgname "magit/with-editor"
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

```emacs-lisp
(:name seq
       :description "Sequence manipulation functions"
       :type elpa
       :website "https://elpa.gnu.org/packages/seq.html")
```

そして `el-get-bundle` でインストールしている

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
