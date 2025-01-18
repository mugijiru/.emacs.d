+++
title = "パッケージインストール周りの設定"
draft = false
+++

## el-get {#el-get}


### 概要 {#概要}

[el-get](https://github.com/dimitri/el-get) は結構昔からあるパッケージ管理系のものの1つ。自前で recipe を書いてあっちこっちから入れられるので気に入ってずっと使っている


### インストール {#インストール}

まず el-get がインストールされるディレクトリを `load-path` に放り込んでいる。

```emacs-lisp
(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))
```

そして `el-get` が見つからない時はインストールするようにしている

```emacs-lisp
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))
```

このあたりの記述は公式の README に書かれてるやつと一緒だと思う。大分前に設定しているから今は違うかもしれんけど


### レシピのフォルダ指定 {#レシピのフォルダ指定}

自前のレシピをいくつか用意しているのでそのフォルダを el-get で読めるようにしている

```emacs-lisp
(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes"))
```


## el-get-lock {#el-get-lock}


### 概要 {#概要}

[el-get-lock](https://github.com/tarao/el-get-lock) は el-get にバージョンロック機構を追加するパッケージ。随分メンテされてないのでいつ動かなくなってもおかしくないけど私のパッケージ管理はこいつが要になってるので動き続けて欲しい


### インストール {#インストール}

こいつは `el-get-bundle` で入れている。
GitHub で管理されているし master ブランチを使っているし依存関係も el-get だけなのでレシピも作らずにインストールしている

```emacs-lisp
(el-get-bundle tarao/el-get-lock)
```


### 初期化 {#初期化}

とりあえず起動時に初期化する必要があるので初期化している。その際に cl パッケージを require しないといけないのでそれも合わせてやっている

```emacs-lisp
(require 'cl)
(el-get-lock)
```


## leaf.el {#leaf}


### 概要 {#概要}

[leaf.el](https://github.com/conao3/leaf.el) は日本の Emacs 界隈でよく使われている設定管理ユーティリティ。
Yet another [use-package](https://github.com/jwiegley/use-package) なのだけど、それの歯痒いところに対応しているとか。

個人的には el-get  に対応しているので使っていきたい。


### インストール/初期化 {#インストール-初期化}

el-get 本体にはレシピがないので自前で用意している。

```emacs-lisp
(:name leaf
       :website "https://github.com/conao3/leaf.el"
       :description "Yet another package manager for Emacs"
       :type github
       :branch "master"
       :pkgname "conao3/leaf.el")
```

そして `:el-get` キーワードを使いたいので `leaf-keywords.el` のレシピも用意している

```emacs-lisp
(:name leaf-keywords
       :website "https://github.com/conao3/leaf-keywords.el"
       :description "Add additional keywords for leaf.el"
       :type github
       :branch "master"
       :pkgname "conao3/leaf-keywords.el")
```

そして他のパッケージと同様にそれら `el-get-bundle` でインストールしている。インストールと同時に初期化も行っている。

```emacs-lisp
(el-get-bundle leaf)
(el-get-bundle leaf-keywords)
(leaf-keywords-init)
```

このあたりは el-get が入ってる前提で設定しているので公式 README とは異なる方法を採用している


## el-get 関係の自前関数 {#el-get-functions}

el-get と el-get-lock を使った関数を用意している

説明は面倒なので今のところはとりあえず tangle するコードだけ置いとくね

```emacs-lisp
(defun my/el-get-auto-update (package)
  (let ((el-get-default-process-sync t)
        (old-checksum (my/el-get-lock-checksum package)))
    (el-get-lock-checkout "el-get")
    (sit-for 10) ;; el-get がなんか読み込まれてるので待ってみる
    (el-get-lock-checkout package)
    (el-get-update package)
    (let ((new-checksum (my/el-get-lock-checksum package)))
      (unless (string= old-checksum new-checksum)
        (let* ((compare (concat old-checksum "..." new-checksum))
               (recipe (ignore-errors (el-get-package-def package)))
               (type (plist-get recipe :type))
               (pkgname (plist-get recipe :pkgname))
               (url (plist-get recipe :url))
               (title (concat "Update " package))
               (body (cond
                      ((eq type 'github)
                       (concat "https://github.com/" pkgname "/compare/" compare))
                      ((string-match (concat "^" "https://codeberg.org/") url)
                       (concat (substring url 0 (- (length url) 4)) "/compare/" compare))
                      (t
                       (concat "compare: " compare))))
               (commit-message (concat title "\n\n" body)))
          (write-region commit-message nil "/tmp/commit-message.txt"))))))

(defun my/el-get-lock-checksum (package)
  (let ((versions (cdr el-get-lock-package-versions))
        (package-sym (intern package)))
    (cadr (alist-get package-sym (cdr el-get-lock-package-versions)))))
```
