(el-get-bundle typescript-mode)

(custom-set-variables
 '(typescript-indent-level 2)
 '(lsp-typescript-locale "ja")
 '(lsp-inlay-hint-enable t)
 '(lsp-javascript-display-parameter-name-hints t)
 '(lsp-javascript-display-enum-member-value-hints t)
 '(lsp-clients-typescript-max-ts-server-memory 2048)
 '(lsp-disabled-clients '())
 '(lsp-eslint-auto-fix-on-save nil)
 )

(defun my/ts-mode-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "ts")
    (lsp-eslint-fix-all)))

(defun my/ts-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (subword-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode t)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'my/ts-mode-auto-fix-hook nil 'local))

(add-hook 'typescript-mode-hook 'my/ts-mode-hook)

(add-to-list 'auto-mode-alist '("\\.ts" . typescript-mode))

(add-to-list 'context-skk-programming-mode 'typescript-mode)
