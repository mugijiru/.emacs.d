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
