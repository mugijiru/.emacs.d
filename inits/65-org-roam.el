(el-get-bundle org-roam)

(custom-set-variables
 '(org-roam-directory (file-truename org-directory)))

;; (org-roam-db-autosync-mode 1)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define org-roam-hydra (:separator "-"
                                                  :color teal
                                                  :foreign-key warn
                                                  :title (concat (all-the-icons-material "graphic_eq") " Roam")
                                                  :quit-key "q")
    ("commands"
     (("i" org-roam-node-insert "Insert")))))
