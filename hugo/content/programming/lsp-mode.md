+++
title = "lsp-mode"
draft = false
+++

## 概要 {#概要}

[lsp-mode](https://github.com/emacs-lsp/lsp-mode) は Emacs で Language server protocol が使えるようにするパッケージ。

より軽そうなやつに [eglot](https://github.com/joaotavora/eglot) というのもあるがこっちは試したことがない。


## インストール {#インストール}

lsp-mode 本体と
UI 周りを担当する lsp-ui-mode の両方をインストールしている。また lsp-mode が有効になる際に lsp-ui-mode も同時に有効になるようにしている。

```emacs-lisp
(el-get-bundle lsp-mode)
(el-get-bundle lsp-ui)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)
```


## 設定 {#設定}

lsp-ui-doc はカーソル位置にある変数や関数などの説明を child frame で表示してくれるやつ。

これがデフォルトではフレーム基準で右上に表示するのだが大きめの画面を分割して使っていると大分遠くに表示されてしまうので
window 基準で表示するように設定を変更している

```emacs-lisp
(setq lsp-ui-doc-alignment 'window)
```
