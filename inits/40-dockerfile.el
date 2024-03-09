(el-get-bundle dockerfile-mode)

(custom-set-variables
 '(dockerfile-indent-offset 2))

(defun my/dockerfile-mode-hook ()
  (display-line-numbers-mode t)
  (flycheck-mode 1)
  (lsp))

(add-hook 'dockerfile-mode-hook 'my/dockerfile-mode-hook)
(add-hook 'dockerfile-ts-mode-hook 'my/dockerfile-mode-hook)
