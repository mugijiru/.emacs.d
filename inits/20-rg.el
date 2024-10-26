(el-get-bundle rg)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define rg-mode (:separator "-" :quit-key "q" :title "rg-mode")
    ("General"
     (("m" rg-menu "Transient menu")))))
