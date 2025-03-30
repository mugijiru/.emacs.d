(el-get-bundle rspec-mode)

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(define-key rspec-mode-map (kbd "C-c C-c") 'rspec-verify-single)

(defun my/rspec-imenu-create-index (_symbols)
  "Ignore LSP mode imenu create index function."
  (remove-function (local 'imenu-create-index-function) #'lsp--imenu-create-index)
  (funcall 'imenu-create-index-function)
  (advice-add 'imenu-create-index-function :override 'lsp--imenu-create-index))

(defun my/rspec-mode-hook ()
  "set rspec mode hook."
  (setq-local lsp-imenu-index-function 'my/rspec-imenu-create-index))

(add-hook 'rspec-mode-hook 'my/rspec-mode-hook)
