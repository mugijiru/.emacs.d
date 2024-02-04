(el-get-bundle copilot)

;; (add-hook 'prog-mode-hook 'copilot-mode)
(with-eval-after-load 'copilot
  (add-to-list 'copilot-major-mode-alist '("enh-ruby" . "ruby")))

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))

(setq warning-suppress-log-types '((copilot copilot-exceeds-max-char)))
