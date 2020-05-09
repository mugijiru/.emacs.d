(el-get-bundle dashboard)

;; 表示するアイコンをロゴに変更
(setq dashboard-startup-banner 'logo)

;; 表示する情報の設定
(setq dashboard-items '((recents  . 5)
                        ;; (bookmarks . 5) ;; bookmarks は使ってない
                        (projects . 5)
                        (agenda . 5)
                        ;; (registers . 5) ;; registers は使ってない
                        ))

;; 各セクションのタイトル部の先頭にアイコンを表示
(setq dashboard-set-heading-icons t)

;; 各ファイルの先頭にアイコンを表示
(setq dashboard-set-file-icons t)
(dashboard-setup-startup-hook)
