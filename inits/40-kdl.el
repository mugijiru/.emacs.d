(el-get-bundle kdl-mode)

(defun my/kdl-mode-hook ()
  (setq-local tab-width 4))

(add-hook 'kdl-mode-hook 'my/kdl-mode-hook)
