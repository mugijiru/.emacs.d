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


## キーバインドの追加 {#キーバインドの追加}

テスト用のファイルを開いたら `C-c C-c` でテストを実行できるようにするためキーバインドを設定

```emacs-lisp
(defun my/setup-web-mode-map ()
  (let ((keymap web-mode-map))
    (define-key keymap (kbd "C-c C-c") 'my/mocha-test-file)))
```


## 自動フォーマット hook の用意 {#自動フォーマット-hook-の用意}

tsx の保存時に自動でフォーマットしてほしいのでそれ用に hook を追加

```emacs-lisp
(defun my/web-mode-auto-fix-hook ()
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
(defun my/web-mode-tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-enable-auto-indentation nil)
      (company-mode 1)
      (turn-on-smartparens-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1)
      (add-hook 'before-save-hook 'my/web-mode-auto-fix-hook nil 'local)
      (my/setup-web-mode-map))))

(add-hook 'web-mode-hook 'my/web-mode-tsx-hook)
```
