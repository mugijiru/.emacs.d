(el-get-bundle yasnippet)

(yas-global-mode 1)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    yasnippet-hydra (:separator "-" :title "Yasnippet" :foreign-key warn :quit-key "q" :exit t)
    ("Edit"
     (("n" yas-new-snippet        "New")
      ("v" yas-visit-snippet-file "Visit"))

     "Other"
     (("i" yas-insert-snippet  "Insert")
      ("l" yas-describe-tables "List")
      ("r" yas-reload-all      "Reload all")))))
