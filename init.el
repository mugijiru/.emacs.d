(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

(load (concat user-emacs-directory "init-el-get.el"))

(el-get-bundle init-loader)
(init-loader-load)
