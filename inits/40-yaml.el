(el-get-bundle yaml-mode)
(defun my/yaml-mode-hook ()
  (highlight-indent-guides-mode 1))

(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)
