+++
title = "React.js"
draft = false
+++

## 概要 {#概要}

React.js を書くための設定をここにまとめている


## dap-mode {#dap-mode}

Debug Adapter Protocol をサポートするモード。入れておいた方がきっとデバッグしやすいんだろうということで入れている。

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
(add-to-list 'auto-mode-alist '("\\.[jt]sx" . web-mode))
```


## lsp-mode などの有効化 {#lsp-mode-などの有効化}

jsx/tsx ファイルを開く時に web-mode が有効になるようにしているのでその web-mode の hook で

-   display-line-numbers-mode
-   lsp
-   lsp-ui-mode

を有効にしている。

```emacs-lisp
(defun my/web-mode-tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (turn-on-smartparens-strict-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1))))

(add-hook 'web-mode-hook 'my/web-mode-tsx-hook)
```
