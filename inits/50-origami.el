(el-get-bundle origami)

(with-eval-after-load 'origami
  (define-key origami-mode-map (kbd "<backtab>") 'origami-recursively-toggle-node)
  (define-key origami-mode-map (kbd "M-<backtab>") 'origami-show-only-node))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define origami-hydra
    (:separator "-" :quit-key "q" :title "Origami")
    ("Node"
     (("o" origami-open-node "Open")
      ("c" origami-close-node "Close")
      ("s" origami-show-node "Show")
      ("t" origami-toggle-node "Toggle")
      ("S" origami-forward-toggle-node "Foward toggle")
      ("r" origami-recursively-toggle-node "Recursive toggle"))

     "All"
     (("O" origami-open-all-nodes "Open")
      ("C" origami-close-all-nodes "Close")
      ("T" origami-toggle-all-nodes "Toggle"))

     "Move"
     (("n" origami-next-fold "Next")
      ("p" origami-previous-fold "Previous"))

     "Undo/Redo"
     (("/" origami-undo "Undo")
      ("?" origami-redo "Redo")
      ("X" origami-reset "Reset")))))
