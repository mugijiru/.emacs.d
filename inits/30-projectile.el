(el-get-bundle projectile)

(el-get-bundle helm-projectile)
(helm-projectile-on)

(projectile-mode)

;; 無視するディレクトリ
(add-to-list 'projectile-globally-ignored-directories "tmp")
(add-to-list 'projectile-globally-ignored-directories ".tmp")
(add-to-list 'projectile-globally-ignored-directories "vendor")
(add-to-list 'projectile-globally-ignored-directories ".sass-cache")
(add-to-list 'projectile-globally-ignored-directories "coverage")
(add-to-list 'projectile-globally-ignored-directories "cache")
(add-to-list 'projectile-globally-ignored-directories "log")

;; 無視するファイル
(add-to-list 'projectile-globally-ignored-files "gems.tags")
(add-to-list 'projectile-globally-ignored-files "project.tags")
(add-to-list 'projectile-globally-ignored-files "manifest.json")

(setq projectile-completion-system 'ivy)
