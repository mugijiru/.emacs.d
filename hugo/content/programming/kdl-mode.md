+++
title = "kdl-mode"
draft = false
+++

## 概要 {#概要}

[kdl-mode](https://github.com/emacsmirror/kdl-mode) は [KDL](https://kdl.dev/) というコンフィグ用言語向けの major-mode
[zellij](https://zellij.dev/) の設定ファイルが KDL で書かれているので


## インストール {#インストール}

ひとまず recipe を自前で用意している

```emacs-lisp
(:name kdl-mode
       :website "https://github.com/emacsmirror/kdl-mode"
       :description "Emacs major mode for editing the KDL document language"
       :type github
       :pkgname "emacsmirror/kdl-mode"
       :branch "main")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle kdl-mode)
```


## 設定 {#設定}

ひとまず tab-width を半角スペース4つに設定する hook 用の関数を用意して
それを hook に追加している

```emacs-lisp
(defun my/kdl-mode-hook ()
  (setq-local tab-width 4))

(add-hook 'kdl-mode-hook 'my/kdl-mode-hook)
```
