(el-get-bundle terraform-mode)

(custom-set-variables
 '(terraform-format-on-save t))

(el-get-bundle company-terraform)

(company-terraform-init)

(defun my/terraform-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (setq-local lsp-terraform-ls-enable-show-reference t)
  (setq-local lsp-semantic-tokens-enable t)
  (setq-local lsp-semantic-tokens-honor-refresh-requests t)
  (setq-local lsp-enable-links t)
  (lsp)
  (setq-local flycheck-checker 'terraform)
  (setq-local flycheck-disabled-checkers '(terraform-tflint))
  (flycheck-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'terraform-mode-hook 'my/terraform-mode-hook)
