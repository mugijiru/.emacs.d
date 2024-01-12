+++
title = "JSON"
draft = false
+++

## 概要 {#概要}

パッケージの設定ファイルなどでよく使われているファイル形式。


### json-mode {#json-mode}

[json-mode](https://github.com/json-emacs/json-mode) は Emacs で JSON を編集するためのモード。


#### インストール {#インストール}

いつも通り `el-get-bundle` でインストール。

```emacs-lisp
(el-get-bundle json-mode)
```


### hook {#hook}

補完を有効にしたり LSP を使えるようにしたり保存時に自動整形させたりするため
hook を色々突っ込んでる

```emacs-lisp
(defun my/json-mode-hook ()
  (company-mode 1)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local)
  (turn-on-smartparens-strict-mode)
  (flycheck-mode 1)
  (flycheck-select-checker 'json-jq)
  (highlight-indent-guides-mode 1)
  (display-line-numbers-mode 1))

(add-hook 'json-mode-hook 'my/json-mode-hook)
```
