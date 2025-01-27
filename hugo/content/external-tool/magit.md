+++
title = "magit"
draft = false
+++

## 概要 {#概要}

[magit](https://github.com/magit/magit) は Emacs の上で Git の色々な操作ができるやつ。結構使いやすいのでオススメなやつ。

[forge](https://github.com/magit/forge) を使うと GitHub や GitLab とも連携できてさらに便利、なはず。


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
       :minimum-emacs-version "26.1"
       ;; Note: `git-commit' is shipped with `magit' code itself.
       ;; Note: `magit-section' is shipped with `magit' code itself.
       :depends (dash transient with-editor compat seq)
       ;; :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.  Create an
       ;; empty autoloads file because magit.el explicitly checks for
       ;; a file of that name.
       :build `(;; ("make" ,(format "EMACS=%s" el-get-emacs) "docs") do not build manual
                ("touch" "lisp/magit-autoloads.el"))
       :build/berkeley-unix `(;; ("gmake" ,(format "EMACS=%s" el-get-emacs) "docs")
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
       :build `(("make" ,(format "EMACS=%s" el-get-emacs) "info")
                ("git" "checkout" "**/*.texi")) ;; Avoid the need for a clean checkout
       :build/berkeley-unix `(("gmake" ,(format "EMACS=%s" el-get-emacs)
                               "info")))
```

```emacs-lisp
(:name seq
       :description "Sequence manipulation functions"
       :type elpa
       :website "https://elpa.gnu.org/packages/seq.html")
```

transient や forge は el-get にあるレシピでは info を build するようになっているが
build されるとリポジトリに差分が発生して update ができなくなるのでその差分はなかったことにするようにしている

```emacs-lisp
(:name transient
       :website "https://github.com/magit/transient#readme"
       :description "Transient commands used by magit."
       :type github
       :pkgname "magit/transient"
       :branch "main"
       :minimum-emacs-version "25.1"
       :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.
       :build `(("make" ,(format "EMACS=%s" el-get-emacs) "info")
                ("git" "checkout" "docs/transient.texi")) ;; fix: Revert docs/transient.texi changes
       :build/berkeley-unix `(("gmake" ,(format "EMACS=%s" el-get-emacs)
                               "info"))
       ;; Assume windows lacks a build environment.
       :build/windows-nt (with-temp-file "lisp/transient-autoloads.el" nil))
```

```emacs-lisp
(:name forge
       :website "https://github.com/magit/forge#readme"
       :description "Work with Git forges from the comfort of Magit."
       :type github
       :pkgname "magit/forge"
       :branch "main"
       :minimum-emacs-version "25.1"
       ;; The package.el dependency is on `emacsql-sqlite', but el-get
       ;; provides that via `emacsql'.
       :depends (compat closql dash emacsql ghub let-alist magit markdown-mode
                        seq transient yaml)
       :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.
       :build `(("make" ,(format "EMACS=%s" el-get-emacs) "info")
                ("git" "checkout" "docs/forge.texi")) ;; fix: Revert docs/forge.texi changes
       :build/berkeley-unix `(("gmake" ,(format "EMACS=%s" el-get-emacs)
                               "info")))
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle magit)
```


## その他設定 {#その他設定}

ghub を load-path に入れないとうまくいかなかった時があったので load-path に入れてたりします。

```emacs-lisp
(with-eval-after-load 'magit
  (add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/ghub/lisp")))
```

ghub は compat に依存するようになったのでとりあえず自前で recipe を用意している

```emacs-lisp
(:name ghub
       :type github
       :description "Minuscule client for the Github API"
       :pkgname "magit/ghub"
       :depends (let-alist treepy compat llama)
       :branch "main"
       :info "docs"
       :load-path "lisp/"
       :compile "lisp/"
       ;; Use the Makefile to produce the info manual, el-get can
       ;; handle compilation and autoloads on its own.
       :build `(("make" ,(format "EMACS=%s" el-get-emacs) "info"))
       :build/berkeley-unix `(("gmake" ,(format "EMACS=%s" el-get-emacs)
                               "info")))
```

さらに ghub が [llama](https://github.com/tarsius/llama) というパッケージに依存するようになったのでそれ用のレシピも用意している

```emacs-lisp
(:name llama
       :website "https://github.com/tarsius/llama"
       :description "Compact syntax for short lambda"
       :type github
       :pkgname "tarsius/llama"
       :minimum-emacs-version "26.1"
       :depends (compat))
```


## 使い方 {#使い方}

Git 管理されてるファイルを開いている時に
`M-x magit` とかすると Git 管理用のバッファが出て来るしそこで `?` を叩いたらどういうコマンドが使えるのか教えてくれるよ(雑)
