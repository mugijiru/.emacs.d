;; 一部のモードでは mode-line を表示しないようにする
(el-get-bundle hide-mode-line)
(add-hook 'neotree-mode-hook #'hide-mode-line-mode)

(el-get-bundle diminish)
(require 'diminish)

(defmacro my/diminish (file mode &optional new-name)
  "https://github.com/larstvei/dot-emacs/blob/master/init.org"
  `(with-eval-after-load ,file
     (diminish ,mode ,new-name)))

;; minor-mode
(my/diminish "helm" 'helm-mode " ^")
(my/diminish "git-gutter" 'git-gutter-mode " GG")
(my/diminish "yasnippet" 'yas-minor-mode " Ys")
(my/diminish "whitespace" 'whitespace-mode "◽")
(my/diminish "whitespace" 'global-whitespace-mode "◽")

;; major-mode
(add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name "λ")))
(add-hook 'enh-ruby-mode-hook (lambda () (setq mode-name "e💎")))
(add-hook 'ruby-mode-hook (lambda () (setq mode-name "💎")))
