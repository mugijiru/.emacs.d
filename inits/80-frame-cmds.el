(el-get-bundle frame-cmds)

(pretty-hydra-define window-control-hydra (:separator "-" :title "Window Control" :exit nil :quit-key "q")
  ("Move"
   (("h" move-frame-left  "Left")
    ("j" move-frame-down  "Down")
    ("k" move-frame-up    "Up")
    ("l" move-frame-right "Right"))

   "Resize"
   (("H" shrink-frame-horizontally "H-")
    ("J" enlarge-frame "V+")
    ("K" shrink-frame "V-")
    ("L" enlarge-frame-horizontally "H+"))))
