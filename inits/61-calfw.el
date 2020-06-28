(el-get-bundle japanese-holidays)
(require 'japanese-holidays)
(setq calendar-holidays (append japanese-holidays))

(el-get-bundle calfw)
(require 'calfw)
(require 'calfw-org)
