(el-get-bundle persist)

(el-get-bundle org-gcal)

(custom-set-variables
 '(org-gcal-client-id (plist-get (nth 0 (auth-source-search :host "googleusercontent.com")) :client))
 '(org-gcal-client-secret (funcall (plist-get (nth 0 (auth-source-search :host "googleusercontent.com" :max 1)) :secret))))

(require 'org-gcal)

(add-to-list 'plstore-encrypt-to (funcall (plist-get (nth 0 (auth-source-search :host "org-gcal-plstore" :max 1)) :secret)))

(my/load-config "my-org-gcal-config")

(setq appt-display-format 'window)

(defun my/appt-alert (min-to-app _new-time msg)
  (interactive)
  (let ((title (format "あと %s 分" min-to-app)))
    (alert msg :title title)))

(setq appt-disp-window-function 'my/appt-alert)

(advice-add #'org-gcal--sync-unlock :after #'my/org-refresh-appt)
