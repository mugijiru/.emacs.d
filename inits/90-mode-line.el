;; 一部のモードでは mode-line を表示しないようにする
(el-get-bundle hide-mode-line)
(add-hook 'neotree-mode-hook #'hide-mode-line-mode)

;; 日時を modeline で表示
(display-time-mode 1)

;; (el-get-bundle smart-mode-line)
;; (defvar sml/no-confirm-load-theme t)
;; (defvar sml/theme 'dark)
;; (sml/setup)

;; major-mode
;; (add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "elisp"))))
;; (add-hook 'enh-ruby-mode-hook (lambda () (setq mode-name (concat "e" (all-the-icons-alltheicon "ruby-alt")))))
;; (add-hook 'ruby-mode-hook (lambda () (setq mode-name (all-the-icons-alltheicon "ruby-alt"))))
;; (add-hook 'vue-mode-hook (lambda ()
;;                            (make-local-variable 'mmm-submode-mode-line-format)
;;                            (setq mmm-submode-mode-line-format "~M:~m")
;;                            (make-local-variable 'mmm-buffer-mode-display-name)
;;                            (setq mmm-buffer-mode-display-name "V")))
;; (add-hook 'js-mode-hook (lambda () (setq mode-name "")))
;; (add-hook 'pug-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "pug"))))
;; (add-hook 'css-mode-hook (lambda () (setq mode-name (all-the-icons-faicon "css3"))))
;; (add-hook 'twittering-mode-hook (lambda () (setq mode-name (all-the-icons-faicon "twitter-square"))))
;; (add-hook 'org-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "org"))))

(el-get-bundle diminish)
(require 'diminish)

(defmacro my/diminish (file mode &optional new-name)
  "https://github.com/larstvei/dot-emacs/blob/master/init.org"
  `(with-eval-after-load ,file
     (diminish ,mode ,new-name)))

;; minor-mode
;; (my/diminish "helm" 'helm-mode ":helmet-with-cross:")
;; (my/diminish "git-gutter" 'git-gutter-mode (all-the-icons-octicon "git-compare"))
;; (my/diminish "paredit" 'paredit-mode "()")
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
