(el-get-bundle paredit)
(defun my/emacs-lisp-mode-hook ()
  (paredit-mode 1))
(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-mode-hook)
