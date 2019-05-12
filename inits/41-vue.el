(el-get-bundle vue-mode)
(el-get-bundle pug-mode)
(defun my/css-mode-hook ()
  (make-local-variable 'flycheck-checker)
  (setq flycheck-checker 'css-stylelint)
  (rainbow-mode))

(add-hook 'css-mode-hook 'my/css-mode-hook)
(add-hook 'vue-mode-hook 'flycheck-mode)
