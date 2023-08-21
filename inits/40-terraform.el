(el-get-bundle terraform-mode)

(custom-set-variables
 '(terraform-format-on-save t))

(defun my/terraform-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (setq-local flycheck-checker 'terraform)
  (setq-local flycheck-disabled-checkers '(terraform-tflint))
  (flycheck-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'terraform-mode-hook 'my/terraform-mode-hook)
