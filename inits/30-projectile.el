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

(defun my/projectile-goto-file (file-path)
  "Go to the file path"
  (let ((path (concat (projectile-acquire-root) file-path)))
    (cond
     ((file-exists-p path)
      (find-file path))
     (t
      (message "%s is not found." file-path)))))

(defun my/projectile-find-file-in-dir (dir-path)
  "Find the file path"
  (interactive)
  (let ((path (concat (projectile-acquire-root) dir-path)))
    (cond
     ((and (file-exists-p path) (file-directory-p path))
      (projectile-find-file-in-directory path))
     (t
      (user-error "%s is not directory." dir-path)))))

(defun my/projectile-goto-dockerfile ()
  "Find the Gemfile"
  (interactive)
  (my/projectile-goto-file "Dockerfile"))

(defun my/projectile-goto-circleci-config ()
  "Find the CircleCI config.yml"
  (interactive)
  (my/projectile-goto-file ".circleci/config.yml"))

(defun my/projectile-goto-gemfile ()
  "Find the Gemfile"
  (interactive)
  (my/projectile-goto-file "Gemfile"))
