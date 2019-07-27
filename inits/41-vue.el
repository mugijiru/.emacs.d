(define-auto-insert "\\.vue$" "template.vue")

(el-get-bundle vue-mode)
(el-get-bundle pug-mode)
(defun my/css-mode-hook ()
  (make-local-variable 'flycheck-checker)
  (setq flycheck-checker 'css-stylelint)
  (rainbow-mode 1))

(defun my/vue-mode-hook ()
  (display-line-numbers-mode t)
  (flycheck-mode 1))

(add-hook 'css-mode-hook 'my/css-mode-hook)
(add-hook 'vue-mode-hook 'my/vue-mode-hook)
