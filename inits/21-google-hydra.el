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

     "Other"
     (("1" engine/search-rurema-3.1  "Rurema 3.1")
      ("2" engine/search-rurema-3.2  "Rurema 3.2")
      ("3" engine/search-rurema-3.3  "Rurema 3.3")
      ("0" engine/search-rails       "Rails")
      ("S" engine/search-rspec       "RSpec")
      ("g" engine/search-github-code "GitHub code"))

     "Tool"
     (("W" google-this-forecast "Weather")))))
