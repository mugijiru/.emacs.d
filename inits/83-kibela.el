(el-get-bundle emacs-kibela)

(custom-set-variables
 '(kibela-auth-list `(("Work"
                       ,(plist-get (nth 0 (auth-source-search :host "emacs-kibela-work")) :team)
                       ,(funcall (plist-get (nth 0 (auth-source-search :host "emacs-kibela-work" :max 1)) :secret)))
                      ("Private"
                       ,(plist-get (nth 0 (auth-source-search :host "emacs-kibela-private")) :team)
                       ,(funcall (plist-get (nth 0 (auth-source-search :host "emacs-kibela-private" :max 1)) :secret))))))

(defun my/kibela-show-recent-note ()
  "最近投稿された記事を見るためのコマンド
ivy-kibela-recent で最近投稿された記事を拾って
kibela-note-show でバッファを開く"
  (interactive)
  (ivy-kibela-recent (lambda (title)
                       (let ((id (get-text-property 0 'id title)))
                         (if id
                             (kibela-note-show id))))))

(pretty-hydra-define kibela-hydra (:separator "-" :title "Kibela" :foreign-key warn :quit-key "q" :exit t)
  ("ivy"
   (("r" ivy-kibela-recent "Recent")
    ("R" ivy-kibela-recent-browsing-notes "Recent brwosing notes")
    ("S" ivy-kibela-search "Search"))
   "Group"
   (("g" kibela-group-notes "notes"))
   "Note"
   (("n" kibela-note-new "New")
    ("s" my/kibela-show-recent-note "Show")
    ("t" kibela-note-new-from-template "From template"))
   "Team"
   (("x" kibela-switch-team "Swtich"))))
