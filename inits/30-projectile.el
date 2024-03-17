(el-get-bundle projectile)

(projectile-mode)

(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories ".tmp")
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories ".sass-cache")
(add-to-list 'projectile-globally-ignored-directories "coverage")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "log")

(add-to-list 'projectile-globally-ignored-files "gems.tags")
(add-to-list 'projectile-globally-ignored-files "project.tags")
(add-to-list 'projectile-globally-ignored-files "manifest.json")

(setq projectile-completion-system 'ivy)
(el-get-bundle counsel-projectile)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    projectile-hydra (:separator "-" :title "Projectile" :foreign-key warn :quit-key "q" :exit t)
    ("File"
     (("f" counsel-projectile-find-file "Find File")
      ("d" counsel-projectile-find-dir "Find Dir")
      ("r" projectile-recentf "Recentf"))

     "Edit"
     (("R" projectile-replace "Replace"))

     "Other"
     (("p" (counsel-projectile-switch-project 'counsel-projectile-switch-project-action-vc) "Switch Project")))))
