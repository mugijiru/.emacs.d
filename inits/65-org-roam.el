(el-get-bundle org-roam)

(custom-set-variables
 '(org-roam-directory (file-truename (concat org-directory "roam/"))))

(org-roam-db-autosync-mode 1)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    org-roam-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-material "graphic_eq") " Roam")
                :quit-key "q")
    ("Node"
     (("f" org-roam-node-find "Find")
      ("r" org-roam-node-random "Random"))

     "DB"
     (("S" org-roam-db-sync "Sync")
      ("C" org-roam-db-clear-all "Clear")))))
