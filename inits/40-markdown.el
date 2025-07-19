(el-get-bundle markdown-mode)

(defun my/markdown-mode-hook()
  (display-line-numbers-mode 1))

(add-hook 'markdown-mode-hook 'my/markdown-mode-hook)
