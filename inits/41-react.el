(el-get-bundle dap-mode)

(el-get-bundle web-mode)

(add-to-list 'auto-mode-alist '("\\.[jt]sx" . web-mode))

(defun my/web-mode-tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (turn-on-smartparens-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1))))

(add-hook 'web-mode-hook 'my/web-mode-tsx-hook)
