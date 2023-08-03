(el-get-bundle hlissner/emacs-hide-mode-line)
(add-hook 'neotree-mode-hook #'hide-mode-line-mode)

(custom-set-variables '(display-time-24hr-format t))
(display-time-mode -1)

(el-get-bundle diminish)
(require 'diminish)

(defmacro my/diminish (file mode &optional new-name)
  "https://github.com/larstvei/dot-emacs/blob/master/init.org"
  `(with-eval-after-load ,file
     (diminish ,mode ,new-name)))

;; (my/diminish "git-gutter" 'git-gutter-mode (all-the-icons-octicon "git-compare"))
;; (my/diminish "yasnippet" 'yas-minor-mode " Ys")
;; (my/diminish "whitespace" 'whitespace-mode "◽")
;; (my/diminish "whitespace" 'global-whitespace-mode "◽")
;; (my/diminish "tempbuf" 'tempbuf-mode "")
;; (my/diminish "flycheck" 'flycheck-mode "")
;; (my/diminish "zoom" 'zoom-mode "")
;; (my/diminish "rainbow" 'rainbow-mode "🌈")
;; (my/diminish "projectile-rails" 'projectile-rails-mode "🛤")
;; (my/diminish "company" 'company-mode "")
;; (my/diminish "ElDoc" 'eldoc-mode "")
