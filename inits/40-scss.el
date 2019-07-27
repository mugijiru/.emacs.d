(el-get-bundle rainbow-mode)
(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))
(defun my/scss-mode-hook ()
  (flycheck-mode 1)
  (make-local-variable 'flycheck-checker)
  (setq flycheck-checker 'scss-stylelint)

  (company-mode 1)
  (display-line-numbers-mode 1)
  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)
