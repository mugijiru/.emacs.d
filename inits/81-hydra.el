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
    ("d" counsel-projectile-find-dir "Find Dir")
    ("f" counsel-projectile-find-file "Find File"))

   "Edit"
   (("v" my/replace-var "Replace Var")
    ("a" align-regexp "Align regexp"))

   "Code"
   (("g" counsel-projectile-ag "Grep")
    ("j" dumb-jump-pretty-hydra/body "Dumb jump"))

   "Tool"
   (("c" my/open-user-calendar "Calendar")
    ("o" global-org-hydra/body "Org")
    ("/" google-this-pretty-hydra/body "Google")
    ("SPC" major-mode-hydra "Hydra(Major)")
    ("t" google-translate-at-point "EN => JP")
    ("T" google-translate-at-point-reverse "JP => EN"))

   "View"
   (("Z" toggle-frame-fullscreen "Fullscreen")
    ("D" delete-other-windows "Only This Win"))

   "Scale"
   (("+" text-scale-increase "Increase")
    ("-" text-scale-decrease "Decrease")
    ("0" text-scale-adjust   "Adjust"))

   "Other"
   (("P" my/open-review-requested-pr "Open Requested PR")
    ("B" counsel-descbinds "Describe Keybind"))))
