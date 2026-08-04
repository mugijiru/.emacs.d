(require 'profiler)
(profiler-start 'cpu)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

(load (expand-file-name "init-el-get.el" user-emacs-directory))

(el-get-bundle init-loader)
(init-loader-load)

(profiler-report)
(profiler-stop)
