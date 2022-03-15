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


### auto-fix の hook 関数 {#auto-fix-の-hook-関数}

保存した時に自動で整形してほしいなと思ったので
auto-fix.el で自動で保存されるように hook 関数を用意している

```emacs-lisp
(defun my/auto-fix-mode-hook-for-ts ()
  (add-hook 'before-save-hook 'auto-fix-before-save))

(add-hook 'auto-fix-mode-hook 'my/auto-fix-mode-hook-for-ts)
```


### hook {#hook}

-   company-mode
-   smartparens-strict-mode
-   lsp/lsp-ui
-   flycheck

などのプログラミングで便利な各種のモードを
hook を使って有効化している

auto-fix はここでもなんか設定しているのでなんか設定まとめたいなあって感じはある。

```emacs-lisp
(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (flycheck-mode 1)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))
  (flycheck-add-next-checker 'lsp '(warning . javascript-eslint))

  (let* ((args (list "run" "eslint" "--fix"))
         (args-string (mapconcat #'shell-quote-argument args " ")))
    (setq-local auto-fix-option args-string))
  (setq-local auto-fix-options '("run" "eslint" "--fix"))
  (setq-local auto-fix-command "yarn")
  (auto-fix-mode 1))
```

この関数を

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
