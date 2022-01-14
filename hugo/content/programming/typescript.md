+++
title = "TypeScript"
draft = false
+++

## 概要 {#概要}

TypeScript ファイル(.ts) を使う上での設定を書いている。とりあえず簡単な設定だけ。


## typescript-mode {#typescript-mode}

[typescript-mode](https://github.com/emacs-typescript/typescript.el) は TypeScript 向けの Syntax Highlight とかを提供してくれるメジャーモード。


### インストール {#インストール}

自分はいつも通り el-get で入れている

```emacs-lisp
(el-get-bundle typescript-mode)
```


### カスタム変数 {#カスタム変数}

indent は2文字がいいのでデフォルトから変更している

```emacs-lisp
(custom-set-variables
 '(typescript-indent-level 2))
```


### hook {#hook}

company-mode などのプログラミングで便利な各種のモードを
hook を使って有効化している

```emacs-lisp
(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1))
```

という関数を用意して

```emacs-lisp
(add-hook 'typescript-mode-hook 'my/ts-mode-hook)
```

として hook に追加している。

直接 lambda で add-hook に書くという手もあるが関数を分離しておくと修正の反映が用意なのでこのようにしている


### 拡張子による有効化 {#拡張子による有効化}

.ts ファイルであれば typescript-mode で動いてほしいので
auto-mode-alist に突っ込んでいる

```emacs-lisp
(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))
```
