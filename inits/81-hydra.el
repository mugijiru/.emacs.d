(el-get-bundle hydra)
(el-get-bundle pretty-hydra)

(pretty-hydra-define dumb-jump-pretty-hydra
  (:foreign-keys warn :title "Dumb jump" :quit-key "q" :color blue)
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

(defhydra hydra-usefull-commands (:color teal)
  "
     ^File^                ^Edit^              ^Search^        ^Other^
------------------------------------------------------------------------------------------
  _p_: switch-project    _v_: repalce var      _g_: grep       _c_: calendar
  _r_: recent file       _a_: align regexp     _j_: dumb jump  _P_: open-requested-pr
  _d_: dir               _+_: 文字拡大         ^ ^             _D_: delete-other-windows
  _f_: find file         _-_: 文字縮小         ^ ^             _q_: cancel

"
  ("p" helm-projectile-switch-project)
  ("r" helm-projectile-recentf)
  ("d" helm-projectile-find-dir)
  ("f" helm-projectile-find-file)

  ("v" my/replace-var)
  ("a" align-regexp)
  ("+" text-scale-increase)
  ("-" text-scale-decrease)

  ("g" helm-projectile-ag)
  ("j" dumb-jump-pretty-hydra/body)

  ("c" my/open-user-calendar)
  ("P" my/open-review-requested-pr)
  ("D" delete-other-windows)
  ("q"   nil "cancel" :color blue))

(pretty-hydra-define pretty-hydra-projectile-rails-find (:color blue :foreign-keys warn :title "Projectile Rails" :quit-key "q")
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
    ("p" projectile-rails-find-spec "Spec"))))

(define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body)
