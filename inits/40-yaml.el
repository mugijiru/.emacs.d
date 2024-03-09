(el-get-bundle yaml-mode)

(defun my/yaml-mode-hook ()
  (lsp 1)
  (flycheck-mode 1)
  (highlight-indent-guides-mode 1))

(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)
(add-hook 'yaml-ts-mode-hook 'my/yaml-mode-hook)
