(setq org-clock-clocktable-default-properties
      '(:maxlevel 10
                  :lang "ja"
                  :scope agenda-with-archives
                  :block today
                  :level 4))

(defun my/org-clock-in-hook ()
  (let* ((task org-clock-current-task)
         (message (format "開始: %s" task)))
    (my/notify-slack-times message))

  (if (org-clocking-p)
      (org-todo "DOING")))

(setq org-clock-in-hook 'my/org-clock-in-hook)

(defun my/org-clock-out-hook ()
  (let* ((task org-clock-current-task)
         (message (format "終了: %s" task)))
    (my/notify-slack-times message)))

(setq org-clock-out-hook 'my/org-clock-out-hook)

(el-get-bundle org-pomodoro)

(custom-set-variables
 '(org-pomodoro-play-sounds nil)
 '(org-pomodoro-length 50)
 '(org-pomodoro-short-break-length 10)
 '(org-pomodoro-long-break-length 30))
