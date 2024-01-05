+++
title = "React.js"
draft = false
+++

## 概要 {#概要}

React.js を書くための設定をここにまとめている


## dap-mode {#dap-mode}

Debug Adapter Protocol をサポートするモード。入れておいた方がきっとデバッグしやすいんだろうということで入れている。

その際に el-get のレシピは自前で用意している

```emacs-lisp
(:name dap-mode
       :description "Debug Adapter Protocol mode"
       :website "https://github.com/emacs-lsp/dap-mode"
       :type github
       :pkgname "emacs-lsp/dap-mode"
       :depends (bui dash f lsp-mode lsp-treemacs tree-mode posframe s lsp-docker))
```

また依存している lsp-docker と tree-mode 用のレシピも用意している

```emacs-lisp
(:name lsp-docker
       :description "lsp-mode uses lsp-docker to run language servers using in containers"
       :website "https://github.com/emacs-lsp/lsp-docker"
       :type github
       :pkgname "emacs-lsp/lsp-docker"
       :depends (dash lsp-mode f yaml ht))
```

```emacs-lisp
(:name tree-mode
       :website "https://github.com/emacsorphanage/tree-mode"
       :description "A mode to manage tree widgets"
       :type github
       :pkgname "emacsorphanage/tree-mode")
```

lsp-mode の仲間なので、本当はそっち側で入れるようにした方が良さそうだけどひとまず React のために入れているので React 用の設定ファイルに書いている。

```emacs-lisp
(el-get-bundle dap-mode)
```

同時に treemacs や lsp-treemacs も入ってくる罠がある。
Neotree 使ってるからちょっとアレだなあ。いずれ乗り換えようとはしていたけども。


## web-mode {#web-mode}

とりあえず tsx を弄る上では web-mode が良いという話もあるので入れておく。

```emacs-lisp
(el-get-bundle web-mode)
```


## メジャーモードの紐付け {#メジャーモードの紐付け}

jsx/tsx ファイルを開いた時には web-mode で動いてほしいので
auto-mode-alist で関連付けをする

```emacs-lisp
(add-to-list 'auto-mode-alist '("\\.tsx" . tsx-ts-mode))
```


## 自動フォーマット hook の用意 {#自動フォーマット-hook-の用意}

tsx の保存時に自動でフォーマットしてほしいのでそれ用に hook を追加

```emacs-lisp
(defun my/tsx-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "tsx")
    (lsp-eslint-fix-all)))
```


## lsp-mode などの有効化 {#lsp-mode-などの有効化}

jsx/tsx ファイルを開く時に web-mode が有効になるようにしているのでその web-mode の hook で

-   display-line-numbers-mode
-   lsp
-   lsp-ui-mode
-   company-mode

を有効にしている。

また

-   保存時の自動補正 hook の追加
-   自動テストのキーバインドの設定

も合わせて行っている。

それ以外にも web-mode の設定も少し弄っていて
indent は2桁スペースになるようにしているが自動インデントだとそれが反映されないっぽいので自動インデントはオフにしている。

なお過去の設定では flycheck も少し設定していたが
lsp-mode から eslint を使うことでやりたいことの対応ができるようなのでその設定は外した。

```emacs-lisp
(defun my/tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-enable-auto-indentation nil)
      (origami-mode 1)
      (company-mode 1)
      (subword-mode 1)
      (turn-on-smartparens-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1)
      (add-hook 'before-save-hook 'my/web-mode-auto-fix-hook nil 'local))))

(add-hook 'tsx-ts-mode-hook 'my/tsx-hook)
```
