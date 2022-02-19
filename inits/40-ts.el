(el-get-bundle typescript-mode)

(custom-set-variables
 '(typescript-indent-level 2))

(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (flycheck-mode 1)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))
  (flycheck-add-next-checker 'lsp '(warning . javascript-eslint))
  )

(add-hook 'typescript-mode-hook 'my/ts-mode-hook)

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))
