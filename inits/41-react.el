(el-get-bundle dap-mode)

(el-get-bundle web-mode)

(add-to-list 'auto-mode-alist '("\\.[jt]sx" . web-mode))

(defun my/setup-web-mode-map ()
  (let ((keymap web-mode-map))
    (define-key keymap (kbd "C-c C-c") 'my/mocha-test-file)))

(defun my/web-mode-auto-fix-hook ()
  (when (string-equal (file-name-extension buffer-file-name) "tsx")
    (lsp-eslint-fix-all)))

(defun my/web-mode-tsx-hook ()
  (let ((ext (file-name-extension buffer-file-name)))
    (when (or (string-equal "jsx" ext) (string-equal "tsx" ext))
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-code-indent-offset 2)
      (setq web-mode-enable-auto-indentation nil)
      (origami-mode 1)
      (company-mode 1)
      (turn-on-smartparens-mode)
      (display-line-numbers-mode t)
      (lsp)
      (lsp-ui-mode 1)
      (add-hook 'before-save-hook 'my/web-mode-auto-fix-hook nil 'local)
      (my/setup-web-mode-map))))

(add-hook 'web-mode-hook 'my/web-mode-tsx-hook)
