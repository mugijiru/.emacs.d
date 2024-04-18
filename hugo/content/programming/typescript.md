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

-   indent は2文字がいいのでデフォルトから変更
-   言語設定を ja にする。エラーが日本語で出るようになるとか……?
-   inlay-hint を有効にする。何が変わるかわかってないけど
-   Node.js の使用メモリも 2048 MB に増加。メモリ足らんってなる時があったので
-   保存時の自動フォーマット

などを設定している。

```emacs-lisp
(custom-set-variables
 '(typescript-indent-level 2)
 '(lsp-typescript-locale "ja")
 '(lsp-inlay-hint-enable t)
 '(lsp-javascript-display-parameter-name-hints t)
 '(lsp-javascript-display-enum-member-value-hints t)
 '(lsp-clients-typescript-max-ts-server-memory 2048)
 '(lsp-disabled-clients '())
 '(lsp-eslint-auto-fix-on-save nil))
```


### auto-fix の hook 関数 {#auto-fix-の-hook-関数}

保存した時に自動で整形してほしいなと思ったので自動で保存されるように hook 関数を用意している

```emacs-lisp
(defun my/ts-mode-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "ts")
    (lsp-eslint-apply-all-fixes)))
```


### hook {#hook}

-   company-mode
-   smartparens-strict-mode
-   lsp/lsp-ui

などのプログラミングで便利な各種のモードを
hook を使って有効化している

```emacs-lisp
(defun my/ts-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (subword-mode 1)
  (which-function-mode 1)
  (copilot-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'my/ts-mode-auto-fix-hook nil 'local))
```

この関数を

```emacs-lisp
(add-hook 'typescript-ts-mode-hook 'my/ts-mode-hook)
```

として hook に追加している。

直接 lambda で add-hook に書くという手もあるが関数を分離しておくと修正の反映が用意なのでこのようにしている。


### 拡張子による有効化 {#拡張子による有効化}

.ts ファイルであれば typescript-mode で動いてほしいので
auto-mode-alist に突っ込んでいる

```emacs-lisp
(add-to-list 'auto-mode-alist '("\\.ts" . typescript-ts-mode))
```

また skk もいい感じに動いてほしいので context-skk-programming-mode を有効にしている

```emacs-lisp
(add-to-list 'context-skk-programming-mode 'typescript-ts-mode)
```
