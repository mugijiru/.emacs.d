(el-get-bundle hydra)

;; hydra-posframe
;; https://github.com/Ladicle/hydra-posframe
;; 画面真ん中に表示されて便利
(el-get-bundle hydra-posframe)
(add-hook 'after-init-hook 'hydra-posframe-enable)

(el-get-bundle pretty-hydra)
(el-get-bundle major-mode-hydra)

(pretty-hydra-define pretty-hydra-usefull-commands (:separator "-" :color teal :foreign-key warn :title "Usefull commands" :quit-key "q")
  ("File"
   (("p" counsel-projectile-switch-project "Switch Project")
    ("r" projectile-recentf "Recentf")
    ("d" counsel-projectile-find-dir "Find dir")
    ("f" counsel-projectile-find-file "Find file"))

   "Edit"
   (("v" my/replace-var "Replace var")
    ("a" align-regexp "Align regexp"))

   "Scale"
   (("+" text-scale-increase "Increase")
    ("-" text-scale-decrease "Decrease")
    ("0" text-scale-adjust   "Adjust"))

   "Search"
   (("g" counsel-projectile-ag "grep")
    ("j" dumb-jump-pretty-hydra/body "Dumb jump"))

   "Tool"
   (("t" google-translate-at-point "Translate")
    ("T" google-translate-at-point-reverse "Translate Reverse")
    ("/" google-this-pretty-hydra/body "Google"))

   "Other"
   (("c" my/open-user-calendar "Calendar")
    ("P" my/open-review-requested-pr "Open Requested PR")
    ("D" delete-other-windows "Delete Other Windows"))))

(define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body)
