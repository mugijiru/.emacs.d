(el-get-bundle emacs-neotree-dev)
;; counsel-projectile を使ってると意味がないのでコメントアウト
;; (setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define neotree-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-octicon "list-unordered") " Neotree"))
    ("Nav"
     (("u"   neotree-select-up-node   "Up")
      ("g"   neotree-refresh          "Refresh")
      ("Q"   neotree-hide             "Hide"))

     "File"
     (("a"   neo-open-file-ace-window "Ace")
      ("N"   neotree-create-node      "Create")
      ("R"   neotree-rename-node      "Rename")
      ("C"   neotree-copy-node        "Copy")
      ("D"   neotree-delete-node      "Delete")
      ("SPC" neotree-quick-look       "Look")
      ;; ("d" neo-open-dired "Dired")
      ;; ("O" neo-open-dir-recursive   "Recursive")
      )
     "Toggle"
     (("z" neotree-stretch-toggle     "Size"        :toggle (not (neo-window--minimize-p)))
      ("h" neotree-hidden-file-toggle "Hidden file" :toggle neo-buffer--show-hidden-file-p)))))
