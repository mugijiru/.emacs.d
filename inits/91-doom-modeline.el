(el-get-bundle doom-modeline)

(doom-modeline-mode 1)

(setq doom-modeline-vcs-max-length 30)

(display-battery-mode 1)

(defun my/inhibit-read-only (orig-fun &rest args)
  "Temporarily disable read-only mode."
  (let ((inhibit-read-only t))
    (apply orig-fun args)))

(advice-add 'doom-modeline-string-pixel-width :around #'my/inhibit-read-only)
