(el-get-bundle hydra)

(defhydra dumb-jump-hydra (:color blue :columns 3)
    "Dumb Jump"
    ("j" dumb-jump-go "Go")
    ("o" dumb-jump-go-other-window "Other window")
    ("e" dumb-jump-go-prefer-external "Go external")
    ("x" dumb-jump-go-prefer-external-other-window "Go external other window")
    ("i" dumb-jump-go-prompt "Prompt")
    ("l" dumb-jump-quick-look "Quick look")
    ("b" dumb-jump-back "Back"))

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
  ("j" dumb-jump-hydra/body)

  ("c" my/open-user-calendar)
  ("P" my/open-review-requested-pr)
  ("D" delete-other-windows)
  ("q"   nil "cancel" :color blue))

(defhydra hydra-projectile-rails-find (:color blue :column 8)
  "
     ^Current^       ^App^             ^Assets^         ^Other^
------------------------------------------------------------------------------------------
  _M_: Model       _m_: Model       _j_: Javscript    _n_: Migration
  _C_: Controller  _c_: Controller  _s_: Stylesheets  _p_: Spec
  _V_: View        _v_: View        ^ ^               _i_: Initializer
  _H_: Helper      _h_: Helper      ^ ^               _r_: Rake Tasks
  ^ ^              _m_: Mailer      ^ ^               _l_: Libs
  ^ ^              _s_: Serializer

"
  ("m" projectile-rails-find-model)
  ("v" projectile-rails-find-view)
  ("c" projectile-rails-find-controller)
  ("h" projectile-rails-find-helper)
  ("l" projectile-rails-find-lib)
  ("j" projectile-rails-find-javascript)
  ;; ("w" projectile-rails-find-component)
  ("s" projectile-rails-find-stylesheet)
  ("p" projectile-rails-find-spec)
  ;; ("u" projectile-rails-find-fixture)
  ;; ("t" projectile-rails-find-test)
  ;; ("f" projectile-rails-find-feature)
  ("i" projectile-rails-find-initializer)
  ;; ("o" projectile-rails-find-log)
  ("@" projectile-rails-find-mailer)
  ;; ("!" projectile-rails-find-validator)
  ;; ("y" projectile-rails-find-layout)
  ("n" projectile-rails-find-migration)
  ("r" projectile-rails-find-rake-task)
  ;; ("b" projectile-rails-find-job)
  ("z" projectile-rails-find-serializer)

  ("M" projectile-rails-find-current-model      "current model")
  ("V" projectile-rails-find-current-view       "current view")
  ("C" projectile-rails-find-current-controller "current controller")
  ("H" projectile-rails-find-current-helper     "current helper")
  ;; ("J" projectile-rails-find-current-javascript "current javascript")
  ;; ("S" projectile-rails-find-current-stylesheet "current stylesheet")
  ;; ("P" projectile-rails-find-current-spec       "current spec")
  ;; ("U" projectile-rails-find-current-fixture    "current fixture")
  ;; ("T" projectile-rails-find-current-test       "current test")
  ;; ("N" projectile-rails-find-current-migration  "current migration")
  ;; ("Z" projectile-rails-find-current-serializer "current serializer")
  )

(define-key projectile-rails-mode-map (kbd "C-c r") 'hydra-projectile-rails-find/body)
