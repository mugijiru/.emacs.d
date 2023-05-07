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
 '(lsp-eslint-auto-fix-on-save t))
```


### キーマップ関数 {#キーマップ関数}

`C-c C-c` でテストを実行できるようにするように keymap を設定する関数を追加。

```emacs-lisp
(defun my/setup-ts-mode-keymap ()
  (let ((keymap typescript-mode-map))
    (define-key keymap (kbd "C-c C-c") 'my/mocha-test-file)))
```


### auto-fix の hook 関数 {#auto-fix-の-hook-関数}

保存した時に自動で整形してほしいなと思ったので自動で保存されるように hook 関数を用意している

```emacs-lisp
(defun my/ts-mode-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "ts")
    (lsp-eslint-fix-all)))
```


### hook {#hook}

-   company-mode
-   smartparens-strict-mode
-   lsp/lsp-ui

などのプログラミングで便利な各種のモードを
hook を使って有効化している

```emacs-lisp
(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'my/ts-mode-auto-fix-hook nil 'local)
  (my/setup-ts-mode-keymap))
```

この関数を

```emacs-lisp
(add-hook 'typescript-mode-hook 'my/ts-mode-hook)
```

として hook に追加している。

直接 lambda で add-hook に書くという手もあるが関数を分離しておくと修正の反映が用意なのでこのようにしている。

なお auto-fix については自社環境で弊害も大きかったので有効化はせずに設定だけ入れている。そろそろフォーマットするかって時だけ有効にするぐらいが良さそう。
toggle できるようにしているしね


### 拡張子による有効化 {#拡張子による有効化}

.ts ファイルであれば typescript-mode で動いてほしいので
auto-mode-alist に突っ込んでいる

```emacs-lisp
(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))
```

また skk もいい感じに動いてほしいので context-skk-programming-mode を有効にしている

```emacs-lisp
(add-to-list 'context-skk-programming-mode 'typescript-mode)
```
