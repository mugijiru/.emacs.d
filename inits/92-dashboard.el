(el-get-bundle dashboard)

(setq dashboard-startup-banner 'logo)

(setq dashboard-items '((recents  . 5)
                        ;; (bookmarks . 5) ;; bookmarks は使ってない
                        (projects . 5)
                        (agenda . 5)
                        ;; (registers . 5) ;; registers は使ってない
                        ))

(setq dashboard-set-heading-icons t)

(setq dashboard-set-file-icons t)

(dashboard-setup-startup-hook)
