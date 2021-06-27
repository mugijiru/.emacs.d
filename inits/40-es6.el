(el-get-bundle js2-mode)

(defun my/js2-mode-hook ()
  (flycheck-mode 1)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))

  (company-mode 1)
  (turn-on-smartparens-strict-mode)

  (setq js2-basic-offset 2))

(add-hook 'js2-mode-hook 'my/js2-mode-hook)

(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
