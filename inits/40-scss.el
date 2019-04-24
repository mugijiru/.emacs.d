(el-get-bundle rainbow-mode)
(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))
(defun my/scss-mode-hook ()
  (flycheck-mode)
  (make-local-variable 'flycheck-checker)
  (setq flycheck-checker 'scss-stylelint)

  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)
