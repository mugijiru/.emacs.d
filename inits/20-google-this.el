(el-get-bundle google-this)

(with-eval-after-load 'pretty-hydra
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
     (("W" google-this-forecast "Weather")))))
