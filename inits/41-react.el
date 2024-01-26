(el-get-bundle dap-mode)

(el-get-bundle web-mode)

(add-to-list 'auto-mode-alist '("\\.tsx" . tsx-ts-mode))

(defun my/tsx-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "tsx")
    (lsp-eslint-apply-all-fixes)))

(defun my/tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-enable-auto-indentation nil)
      (origami-mode 1)
      (company-mode 1)
      (subword-mode 1)
      (turn-on-smartparens-strict-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1)
      (add-hook 'before-save-hook 'my/tsx-auto-fix-hook nil 'local))))

(add-to-list 'context-skk-programming-mode 'tsx-ts-mode)
(add-hook 'tsx-ts-mode-hook 'my/tsx-hook)
