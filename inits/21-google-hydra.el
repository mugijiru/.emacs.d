(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define google-pretty-hydra
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
     (("L" google-this-lucky-search         "Lucky")
      ("i" google-this-lucky-and-insert-url "Insert URL"))

     "Translate"
     (("t" google-translate-at-point         "EN => JP")
      ("T" google-translate-at-point-reverse "JP => EN"))

     "Tool"
     (("W" google-this-forecast "Weather")))))
