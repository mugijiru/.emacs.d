(el-get-bundle typescript-mode)

(custom-set-variables
 '(typescript-indent-level 2))

(defun my/auto-fix-mode-hook-for-ts ()
  (add-hook 'before-save-hook 'auto-fix-before-save))

(add-hook 'auto-fix-mode-hook 'my/auto-fix-mode-hook-for-ts)

(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (flycheck-mode 1)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))
  (flycheck-add-next-checker 'lsp '(warning . javascript-eslint))

  (let* ((args (list "run" "eslint" "--fix"))
         (args-string (mapconcat #'shell-quote-argument args " ")))
    (setq-local auto-fix-option args-string))
  (setq-local auto-fix-options '("run" "eslint" "--fix"))
  (setq-local auto-fix-command "yarn"))

(add-hook 'typescript-mode-hook 'my/ts-mode-hook)

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))
