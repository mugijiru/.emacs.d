(el-get-bundle tempbuf-mode)

(setq my/tempbuf-ignore-files '("~/Documents/org/tasks/reviews.org"
                                "~/Documents/org/tasks/interrupted.org"
                                "~/Documents/org/tasks/next-actions.org"
                                ))

(defun my/find-file-tempbuf-hook ()
  (let ((ignore-file-names (mapcar 'expand-file-name my/tempbuf-ignore-files)))
    (unless (member (buffer-file-name) ignore-file-names)
      (turn-on-tempbuf-mode))))

(add-hook 'find-file-hook 'my/find-file-tempbuf-hook)

(add-hook 'dired-mode-hook 'turn-on-tempbuf-mode)
