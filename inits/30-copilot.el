(el-get-bundle copilot)

;; (add-hook 'prog-mode-hook 'copilot-mode)

(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))

(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "M-f") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion))

(setq warning-suppress-log-types '((copilot copilot-exceeds-max-char)))
