(el-get-bundle json-mode)

(defun my/json-mode-hook ()
  (company-mode 1)
  (lsp)
  (lsp-ui-mode 1)
  (add-hook 'before-save-hook #'lsp-format-buffer nil 'local)
  (turn-on-smartparens-strict-mode)
  (flycheck-mode 1)
  (flycheck-select-checker 'json-jq)
  (highlight-indent-guides-mode 1)
  (display-line-numbers-mode 1))

(add-hook 'json-mode-hook 'my/json-mode-hook)
