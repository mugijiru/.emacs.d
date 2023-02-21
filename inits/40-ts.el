(el-get-bundle typescript-mode)

(custom-set-variables
 '(typescript-indent-level 2)
 '(lsp-typescript-locale "ja")
 '(lsp-javascript-display-parameter-name-hints t)
 '(lsp-javascript-display-enum-member-value-hints t)
 '(lsp-eslint-auto-fix-on-save t))

(defun my/setup-ts-mode-keymap ()
  (let ((keymap typescript-mode-map))
    (define-key keymap (kbd "C-c C-c") 'my/mocha-test-file)))

(defun my/ts-mode-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "ts")
    (lsp-eslint-fix-all)))

(defun my/ts-mode-hook ()
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'my/ts-mode-auto-fix-hook nil 'local)
  (my/setup-ts-mode-keymap))

(add-hook 'typescript-mode-hook 'my/ts-mode-hook)

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))

(add-to-list 'context-skk-programming-mode 'typescript-mode)
