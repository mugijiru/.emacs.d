(add-to-list 'load-path (expand-file-name "~/.emacs.d/secret"))

(defun my/load-config (file)
  (condition-case nil
      (load file)
    (file-missing (message "Load error: %s" file))))
