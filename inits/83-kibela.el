(el-get-bundle emacs-kibela)

(custom-set-variables
 '(kibela-team (plist-get (nth 0 (auth-source-search :host "emacs-kibela")) :team))
 '(kibela-access-token (funcall (plist-get (nth 0 (auth-source-search :host "emacs-kibela" :max 1)) :secret))))

(defun my/kibela-edit-recent-note ()
  "最近投稿された記事を編集するためのコマンド
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
    ("s" ivy-kibela-search "Search"))
   "Note"
   (("n" kibela-note-new "New")
    ("e" my/kibela-edit-recent-note "Edit")
    ("t" kibela-note-new-from-template "From template"))))
