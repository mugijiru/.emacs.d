(el-get-bundle rspec-mode)

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(define-key rspec-mode-map (kbd "C-c C-c") 'rspec-verify-single)
