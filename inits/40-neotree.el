(el-get-bundle emacs-neotree-dev)
;; counsel-projectile を使ってると意味がないのでコメントアウト
;; (setq projectile-switch-project-action 'neotree-projectile-action)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
