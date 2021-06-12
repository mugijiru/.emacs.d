(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

(load "~/.emacs.d/init-el-get.el")

(el-get-bundle init-loader)
(init-loader-load)
