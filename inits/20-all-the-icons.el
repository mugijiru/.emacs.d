(el-get-bundle all-the-icons)
(require 'all-the-icons)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define all-the-icons-hydra (:separator "-" :title "All the icons" :exit t :quit-key "q")
    ("Insert"
     (("a" all-the-icons-insert-alltheicon "All the icons")
      ("f" all-the-icons-insert-fileicon   "File icons")
      ("F" all-the-icons-insert-faicons    "FontAwesome")
      ("m" all-the-icons-insert-material   "Material")
      ("o" all-the-icons-insert-octicon    "Octicon")
      ("w" all-the-icons-insert-wicon      "Weather")
      ("*" all-the-icons-insert            "All")))))
