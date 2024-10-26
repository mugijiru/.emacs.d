+++
title = "rg"
draft = false
+++

## 概要 {#概要}

[rg.el](https://github.com/dajva/rg.el) は [ripgrep](https://github.com/BurntSushi/ripgrep) を使って高速に検索するためのパッケージ。


## インストール {#インストール}

el-get 本体にはレシピがないので自前で用意している。

```emacs-lisp
(:name rg
       :website "https://github.com/dajva/rg.el"
       :description "Use ripgrep in Emacs."
       :type github
       :depends (transient wgrep)
       :pkgname "dajva/rg.el")
```

そしてそれを `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle rg)
```


## キーバインド {#キーバインド}

transient があるのでほぼ用意する必要はないけど最初の起動メニューのキーが覚えられないのでそれだけ定義している

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define rg-mode (:separator "-" :quit-key "q" :title "rg-mode")
    ("General"
     (("m" rg-menu "Transient menu")))))
```
