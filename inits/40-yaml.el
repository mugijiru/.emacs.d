(el-get-bundle yaml-mode)

(el-get-bundle yaml-pro)

(defun my/yaml-mode-hook ()
  (lsp)
  (yaml-pro-mode 1)
  (flycheck-mode 1)
  (highlight-indent-guides-mode 1))

(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)

(with-eval-after-load 'treesit-auto
  (delete 'yaml treesit-auto-langs))
