(my/load-config "my-notify-slack-config")

(setq my/notify-slack-enable-p t)

(defun my/notify-slack-toggle ()
  (interactive)
  (if my/notify-slack-enable-p
      (setq my/notify-slack-enable-p nil)
    (setq my/notify-slack-enable-p t)))

(defun my/notify-slack (channel text)
  (if my/notify-slack-enable-p
      (start-process "my/org-clock-slack-notifier" "*my/org-clock-slack-notifier*" "my-slack-notifier" channel text)))

(defun my/notify-slack-times (text)
  (my/notify-slack my/notify-slack-times-channel text))
