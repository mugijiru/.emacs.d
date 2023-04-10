(el-get-bundle emacs-sqlite3-api)
(el-get-bundle forge)

(with-eval-after-load 'magit
  (require 'sqlite3)
  (require 'forge))

(defun my/forge-post-mode-hook ()
  (flycheck-mode 1))

(with-eval-after-load 'forge
  (add-hook 'forge-post-mode-hook 'my/forge-post-mode-hook))
