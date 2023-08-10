(el-get-bundle dockerfile-mode)

(custom-set-variables
 '(dockerfile-indent-offset 2))

(defun my/dockerfile-mode-hook ()
  (display-line-numbers-mode t)
  (lsp))

(add-hook 'dockerfile-mode-hook 'my/dockerfile-mode-hook)
