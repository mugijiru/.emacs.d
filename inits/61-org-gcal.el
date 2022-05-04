(el-get-bundle persist)

(el-get-bundle org-gcal)

(require 'org-gcal)

(my/load-config "my-org-gcal-config")

(setq appt-display-format 'window)

(defun my/appt-alert (min-to-app _new-time msg)
  (interactive)
  (let ((title (format "あと %s 分" min-to-app)))
    (message title)
    (alert msg :title title)))

(setq appt-disp-window-function 'my/appt-alert)
