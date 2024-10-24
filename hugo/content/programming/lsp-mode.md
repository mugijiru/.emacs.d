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


## カスタム変数 {#カスタム変数}

lsp-ui-doc はカーソル位置にある変数や関数などの説明を child frame で表示してくれるやつ。

これがデフォルトではフレーム基準で右上に表示するのだが大きめの画面を分割して使っていると大分遠くに表示されてしまうので
window 基準で表示するように設定を変更している

```emacs-lisp
(custom-set-variables
 '(lsp-diagnostics-provider :flycheck)
 '(lsp-ui-doc-show-with-cursor t)
 '(lsp-ui-doc-alignment 'window))
```


## パッチ {#パッチ}

文字を拡大している時の折り返しがおかしくならないようにするパッチ

```emacs-lisp
;; Patch
;; https://github.com/emacs-lsp/lsp-ui/issues/184#issuecomment-1158057166
(with-eval-after-load 'lsp-ui-sideline
  (defun lsp-ui-sideline--align (&rest lengths)
    "Align sideline string by LENGTHS from the right of the window."
    (cons (+ (apply '+ lengths)
             (if (display-graphic-p) 1 2))
          'width))
  (defun lsp-ui-sideline--compute-height () nil))
```


## Hydra の設定 {#hydra-の設定}

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-lsp (:separator "-" :color blue :foreign-keys warn :title "LSP" :quit-key "q")
    ("Find"
     (("t" lsp-find-type-definition "type")
      ("x" lsp-find-definition      "definition")
      ("r" lsp-find-references      "references")
      ("i" lsp-find-implementation  "implementation")
      ("d" lsp-find-declaration     "declaration"))

     "Code"
     (("m" lsp-rename        "rename")
      ("f" lsp-format-buffer "format buffer")
      ("F" lsp-format-region "format region"))

     "UI"
     (("M" lsp-ui-imenu                      "imenu")
      ("V" lsp-ui-flycheck-list              "flycheck list")
      ("X" lsp-ui-peek-find-definitions      "def")
      ("R" lsp-ui-peek-find-references       "refs")
      ("I" lsp-ui-peek-find-implementations  "implementation")
      ("S" lsp-ui-peek-find-workspace-symbol "symbol"))

     "Server"
     (("W" lsp-workspace-restart  "Restart")
      ("Q" lsp-workspace-shutdown "Shutdown")
      ("d" lsp-describe-session   "Session")
      ("D" lsp-disconnect         "Disconnect")))))
```


## TSX のインデント調整 {#tsx-のインデント調整}

tab 押下時は web-mode-code-indent-offset 等の設定で動いていたが
indent-region ではそれと違う値(4)でインデントされていて
indent-region を使えずにいた

<https://github.com/emacs-lsp/lsp-mode/issues/2915#issuecomment-855156802>

を参考に
lsp--formatting-indent-aliat に web-mode と tsx-ts-mode の設定を追加することで良い感じにインデントできるように調整している

```emacs-lisp
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp--formatting-indent-alist `(web-mode . web-mode-code-indent-offset))
  (add-to-list 'lsp--formatting-indent-alist `(tsx-ts-mode . typescript-ts-mode-indent-offset))
  (add-to-list 'lsp-file-watch-ignored-directories "tmp")
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]vendor\\'")
  (add-to-list 'lsp-file-watch-ignored-directories "hello-friend-ng")
  (add-to-list 'lsp-file-watch-ignored-directories "ox-hugo"))
```
