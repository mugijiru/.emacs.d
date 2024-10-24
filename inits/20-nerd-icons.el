(el-get-bundle nerd-icons)
(require 'nerd-icons)

;; if nerd-icons are not installed, run M-x nerd-icons-install-fonts

(el-get-bundle nerd-icons-dired)
(add-hook 'dired-mode-hook #'nerd-icons-dired-mode)
