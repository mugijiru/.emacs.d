(el-get-bundle hydra)

;; hydra-posframe
;; https://github.com/Ladicle/hydra-posframe
;; 画面真ん中に表示されて便利
(el-get-bundle hydra-posframe)
(add-hook 'after-init-hook 'hydra-posframe-enable)

(el-get-bundle pretty-hydra)
(el-get-bundle major-mode-hydra)

(major-mode-hydra-define enh-ruby-mode (:quit-key "q")
  ("Enh Ruby"
   (("{" enh-ruby-toggle-block "Toggle block")
    ("e" enh-ruby-insert-end "Insert end"))

   "RSpec"
   (("s" rspec-verify "Run associated spec")
    ("m" rspec-verify-method "Run method spec")
    ("r" rspec-rerun "Rerun")
    ("l" rspec-run-last-failed "Run last failed"))

   "REPL"
   (("i" inf-ruby "inf-ruby"))

   "Other"
   (("j" dumb-jump-go "Dumb Jump"))))

(pretty-hydra-define dumb-jump-pretty-hydra
  (:foreign-keys warn :title "Dumb jump" :quit-key "q" :color blue :separator "-")
  ("Go"
   (("j" dumb-jump-go "Jump")
    ("o" dumb-jump-go-other-window "Other window"))

   "External"
   (("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window"))

   "Lock"
   (("l" dumb-jump-quick-look "Quick look"))

   "Other"
   (("b" dumb-jump-back "Back"))))

(pretty-hydra-define google-this-pretty-hydra
  (:foreign-keys warn :title "Google" :quit-key "q" :color blue :separator "-")
  ("Current"
   (("SPC" google-this-noconfirm "No Confirm")
    ("RET" google-this           "Auto")
    ("w"   google-this-word      "Word")
    ("l"   google-this-line      "Line")
    ("s"   google-this-symbol    "Symbol")
    ("r"   google-this-region    "Region")
    ("e"   google-this-error     "Error"))

   "Feeling Lucky"
   (("L"   google-this-lucky-search         "Lucky")
    ("i"   google-this-lucky-and-insert-url "Insert URL"))

   "Tool"
   (("W" google-this-forecast "Weather"))))

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

(pretty-hydra-define pretty-hydra-projectile-rails-find (:separator "-" :color blue :foreign-keys warn :title "Projectile Rails" :quit-key "q")
  ("Current"
   (("M" projectile-rails-find-current-model      "current model")
    ("V" projectile-rails-find-current-view       "current view")
    ("C" projectile-rails-find-current-controller "current controller")
    ("H" projectile-rails-find-current-helper     "current helper")
    ("P" projectile-rails-find-current-spec       "current spec")
    ("Z" projectile-rails-find-current-serializer "current serializer"))

   "App"
   (("m" projectile-rails-find-model "model")
    ("v" projectile-rails-find-view  "view")
    ("c" projectile-rails-find-controller "controller")
    ("h" projectile-rails-find-helper "helper")
    ("@" projectile-rails-find-mailer "mailer")
    ;; ("y" projectile-rails-find-layout "Layout")
    ("z" projectile-rails-find-serializer "serializer"))

   "Assets"
   (("j" projectile-rails-find-javascript "Javascript")
    ;; ("w" projectile-rails-find-component)
    ("s" projectile-rails-find-stylesheet "CSS"))

   "Other"
   (("n" projectile-rails-find-migration "Migration")
    ("r" projectile-rails-find-rake-task "Rake task")
    ("i" projectile-rails-find-initializer "Initializer")
    ("l" projectile-rails-find-lib "Lib")
    ("p" projectile-rails-find-spec "Spec")
    ("t" projectile-rails-find-locale "Translation"))))

(define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body)
