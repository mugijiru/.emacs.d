(setq auto-save-timeout 15)

(setq auto-save-interval 60)

(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/backup/" t)))

(setq backup-directory-alist '((".*" . "~/.emacs.d/backup")
                               (,tramp-file-name-regexp . nil)))

(setq version-control t)

(setq delete-old-versions t)
