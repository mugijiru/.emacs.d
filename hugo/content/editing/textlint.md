+++
title = "textlint"
draft = false
+++

## 概要 {#概要}

[textlint](https://github.com/textlint/textlint) は plain text や Markdown の校正に使える linter です。そして [flycheck](https://www.flycheck.org/en/latest/) でそれを呼び出すことができるので、変な文章を書いていないかチェックすることができます。


## 設定 {#設定}

textlint の設定を `~/.config/textlint/textlintrc_ja.json` に置いているのでそれを `flycheck-textlint-config` に設定しています。

```emacs-lisp
(custom-set-variables
  '(flycheck-textlint-config "~/.config/textlint/textlintrc_ja.json"))
```


## magit 用の hook 関数の用意 {#magit-用の-hook-関数の用意}

magit で commit message を書く時に自動で textlint が起動するようにするための関数。なんだけど想定通りに動いていない

```emacs-lisp
;; 想定通りに動かない
  (defun my/magit-commit-create-after (&optional arg)
    (ignore arg)
    (flycheck-select-checker 'textlint-no-extension))

;; (with-eval-after-load 'magit
;;   (advice-add 'magit-commit-create :after 'my/magit-commit-create-after))
```


## checker 定義 {#checker-定義}

flycheck のデフォルトでも textlint は動くのですが
magit でコミットメッセージを書く時なんかには動いてくれなかったので拡張子がないファイルの時にも動くように checker を定義 &amp; 追加している。

その際 forge で Pull request を作る時に自動で有効になるようにも調整している。

```emacs-lisp
(with-eval-after-load 'flycheck
  (flycheck-define-checker textlint-no-extension
  "A text prose linter using textlint.

See URL `https://textlint.github.io/'."
  :command ("textlint"
            "--stdin"
            "--stdin-filename" (eval (concat buffer-file-name ".txt"))
            (config-file "--config" flycheck-textlint-config)
            "--format" "json"
            ;; get the first matching plugin from plugin-alist
            "--plugin"
            (eval (flycheck--textlint-get-plugin)))
  :standard-input t
  ;; textlint seems to say that its json output is compatible with ESLint.
  ;; https://textlint.github.io/docs/formatter.html
  :error-parser flycheck-parse-eslint
  ;; textlint can support different formats with textlint plugins, but
  ;; only text and markdown formats are installed by default. Ask the
  ;; user to add mode->plugin mappings manually in
  ;; `flycheck-textlint-plugin-alist'.
  :modes
  (forge-post-mode text-mode)
  :enabled
  (lambda () (and (flycheck--textlint-get-plugin) (null (file-name-extension buffer-file-name))))
  :verify
  (lambda (_)
    (let ((plugin (flycheck--textlint-get-plugin)))
      (list
       (flycheck-verification-result-new
        :label "textlint plugin"
        :message plugin
        :face 'success)))))
  (add-to-list 'flycheck-checkers 'textlint-no-extension)
  (flycheck-add-mode 'textlint-no-extension 'forge-post-mode))
```
