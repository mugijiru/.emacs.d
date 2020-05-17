(el-get-bundle org-trello)
(defun my/org-trello-fetch-buffer ()
  (org-trello-sync-buffer t))

(defun my/org-trello-mode-hook ()
  (major-mode-hydra-define+ org-mode (:quit-key "q" :title (concat (all-the-icons-faicon "trello") " Org & trello"))
    ("Hoge"
     (("i" org-trello-install-board-metadata "Board metadata")
      ("I" org-trello-install-key-and-token "Setup")

      ("V" org-trello-version "Version")
      ("s" my/org-trello-fetch-buffer "← Trello")
      ("S" org-trello-sync-buffer "→ Trello")))))

(add-hook 'org-trello-mode-hook 'my/org-trello-mode-hook)
