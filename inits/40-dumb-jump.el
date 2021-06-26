(el-get-bundle dumb-jump)

(setq dumb-jump-default-project "~/projects")

(setq dumb-jump-selector 'ivy)

(with-eval-after-load 'pretty-hydra
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
     (("b" dumb-jump-back "Back")))))
