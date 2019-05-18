(el-get-bundle japanese-holidays)
(require 'japanese-holidays)
(setq calendar-holidays (append japanese-holidays))

(el-get-bundle calfw)
(el-get-bundle calfw-org)
(require 'calfw)
(require 'calfw-org)

(setq cfw:org-icalendars '("~/Documents/org/org-ical.org" "~/Documents/org/google-calendar.org"))
