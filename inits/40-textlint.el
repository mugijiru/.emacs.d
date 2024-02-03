(custom-set-variables
  '(flycheck-textlint-config "~/.config/textlint/textlintrc_ja.json"))

;; 想定通りに動かない
(defun my/magit-commit-create-after (&optional arg)
  (ignore arg)
  (flycheck-select-checker 'textlint-no-extension))

;; (with-eval-after-load 'magit
;;   (advice-add 'magit-commit-create :after 'my/magit-commit-create-after))

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
