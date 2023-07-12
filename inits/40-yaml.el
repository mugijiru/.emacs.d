(el-get-bundle yaml-mode)

(defun my/yaml-mode-hook ()
  (lsp 1)
  (highlight-indent-guides-mode 1))

(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)
