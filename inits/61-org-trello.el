(el-get-bundle org-trello)
(defun my/org-trello-fetch-buffer ()
  (interactive)
  (org-trello-sync-buffer t))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    org-trello-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-faicon "trello") "  Org Trello commands")
                :quit-key "q")
    ("Install"
     (("i" org-trello-install-board-metadata "Board metadata")
      ("I" org-trello-install-key-and-token "Setup"))

     "Sync"
     (("s" my/org-trello-fetch-buffer "← Trello")
      ("S" org-trello-sync-buffer "→ Trello"))

     "Other"
     (("V" org-trello-version "Version")))))
