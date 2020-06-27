(el-get-bundle hydra)

;; hydra-posframe
;; https://github.com/Ladicle/hydra-posframe
;; 画面真ん中に表示されて便利
(el-get-bundle hydra-posframe)
(add-hook 'after-init-hook 'hydra-posframe-enable)

(el-get-bundle jerrypnz/major-mode-hydra.el)

(pretty-hydra-define el-get-hydra (:separator "-" :title "el-get" :quit-key "q")
  ("Management"
   (("u" el-get-update "Update")
    ("s" el-get-self-update "Self Update")
    ("A" el-get-update-all "Update All")
    ("r" el-get-reload "Reload")
    ("R" el-get-reinstall "Re-install")
    ("U" el-get-remove "Uninstall")
    ("f" el-get-find-recipe-file "Find recipe"))))

(pretty-hydra-define pretty-hydra-usefull-commands (:separator "-" :color teal :foreign-key warn :title (concat (all-the-icons-material "build") " Usefull commands") :quit-key "q")
  ("File"
   (("p" counsel-projectile-switch-project "Switch Project")
    ("r" projectile-recentf "Recentf")
    ("d" counsel-projectile-find-dir "Find Dir")
    ("f" counsel-projectile-find-file "Find File")
    ("l" counsel-locate "Locate"))

   "Edit"
   (("a" align-regexp "Align Regexp"))

   "Code"
   (("g" counsel-projectile-ag "Grep")
    ("j" dumb-jump-pretty-hydra/body "Dumb jump")
    ("i" counsel-imenu "imenu"))

   "View"
   (("D" delete-other-windows "Only This Win")
    ("W" window-control-hydra/body "Window Control"))

   "Scale"
   (("+" text-scale-increase "Increase")
    ("-" text-scale-decrease "Decrease")
    ("0" text-scale-adjust   "Adjust"))

   "Toggle"
   (("z" zoom-mode                 "zoom-mode"      :toggle zoom-mode)
    ("Z" toggle-frame-fullscreen   "Fullscreen"     :toggle (frame-parameter nil 'fullscreen))
    ("N" neotree-toggle            "Neotree"        :toggle (if (fboundp 'neo-global--window-exists-p) (neo-global--window-exists-p) nil))
    ("v" my/toggle-view-mode       "Readonly"       :toggle view-mode)
    ("L" display-line-numbers-mode "Line Number"    :toggle display-line-numbers-mode)
    ("E" toggle-debug-on-error     "Debug on error" :toggle debug-on-error))

   "Describe"
   (("B" counsel-descbinds "Keybind")
    ("F" counsel-describe-function "Function")
    ("V" counsel-describe-variable "Variable")
    ("M" describe-minor-mode "Minor mode"))

   "Tool"
   (("SPC" major-mode-hydra "Hydra(Major)")
    ("c"   counsel-org-capture "Capture")
    ("o"   global-org-hydra/body "Org")
    ("m"   magit-status "Magit")
    ("A"   counsel-osx-app "macOS App")
    ("@"   all-the-icons-hydra/body "All the icons")
    ("e"   el-get-hydra/body "el-get")
    ("/"   google-this-pretty-hydra/body "Google")
    ("t"   google-translate-at-point "EN => JP")
    ("T"   google-translate-at-point-reverse "JP => EN")
    ("P"   my/open-review-requested-pr "Open Requested PR"))))
