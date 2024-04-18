(el-get-bundle rainbow-mode)

(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))

(with-eval-after-load 'flycheck
  (flycheck-define-checker scss-stylelint
    "A SCSS syntax and style checker using stylelint.

See URL `http://stylelint.io/'."
    :command ("stylelint"
              (eval flycheck-stylelint-args)
              (option-flag "--quiet" flycheck-stylelint-quiet)
              (config-file "--config" flycheck-stylelintrc))
    :standard-input t
    :error-parser flycheck-parse-stylelint
    :predicate flycheck-buffer-nonempty-p
    :modes (scss-mode)))

(defun my/scss-mode-hook ()
  (flycheck-mode 1)

  (setq-local lsp-prefer-flymake nil)
  (lsp)
  (lsp-ui-mode -1)

  (smartparens-strict-mode 1)

  ;; lsp-ui とかより後に設定しないと上書きされるのでここに移動した
  (setq-local flycheck-checker 'scss-stylelint)
  (setq-local flycheck-check-syntax-automatically '(save new-line idle-change))

  (origami-mode 1)
  (company-mode 1)
  (subword-mode 1)
  (which-function-mode 1)
  (copilot-mode 1)
  (display-line-numbers-mode 1)

  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)

(defun my/replace-var (point mark)
  (interactive "r")
  (let* ((str (buffer-substring point mark))
         (cmd (concat "fetch-color-var '" str "'"))
         (response (shell-command-to-string cmd)))
    (delete-region point mark)
    (insert response)))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define scss-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
