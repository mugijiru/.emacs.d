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


## wgrep 連携の設定 {#wgrep-連携の設定}

rg.el には [wgrep]({{< relref "wgrep" >}}) と連携するための wgrep-rg.el が付属しているので検索結果を直接編集して一括置換などができる。

まず wgrep-rg から `wgrep-rg-setup` を autoload で呼び出すようにする。なんとなく `with-eval-after-load` で囲んでるが不要な気もする。

```emacs-lisp
(with-eval-after-load 'wgrep
  (autoload 'wgrep-rg-setup "wgrep-rg"))
```

そしてそれを `rg-mode-hook` で呼び出すようにする

```emacs-lisp
(defun my/rg-mode-hook ()
  (wgrep-rg-setup))

(add-hook 'rg-mode-hook 'my/rg-mode-hook)
```


## キーバインド {#キーバインド}

transient があるのでほぼ用意する必要はないけど最初の起動メニューのキーが覚えられないのでとりあえずそれを定義している。また、上で設定した wgrep も呼び出せるようにしている

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define rg-mode (:separator "-" :quit-key "q" :title "rg-mode")
    ("General"
     (("m" rg-menu                    "Transient menu")
      ("w" wgrep-change-to-wgrep-mode "Wgrep")))))
```
