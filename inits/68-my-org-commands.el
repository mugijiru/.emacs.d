(defun my/org-clock-toggle-display ()
  "行の後ろに掛かった作業時間を表示をしたり消したりを切り替える機能。
Hydra から利用するために定義している。"
  (interactive)
  (if org-clock-overlays
      (org-clock-remove-overlays)
    (org-clock-display)))

(defun my/org-todo-keyword-strings ()
  "org-todo-keywords から装飾を省いた文字列のリストを返す関数"
  (mapcar (lambda (element)
            (replace-regexp-in-string "\(.+\)" "" element))
          (cl-remove-if (lambda (elm) (string= "|" elm)) (cl-rest (cl-first org-todo-keywords)))))

(defun my/org-todo ()
  "ivy で TODO ステータスを切り替えるためのコマンド
Hydra から利用するために定義している。"
  (interactive)
  (ivy-read "Org todo: "
            (my/org-todo-keyword-strings)
            :require-match t
            :sort nil
            :action (lambda (keyword)
                      (org-todo keyword))))

(defun my/org-tags-view-only-todo ()
  (interactive)
  (org-tags-view t))

(defun my/open-calendar ()
  (interactive)
  (ivy-read "Calendar: "
            my/calendar-targets
            :require-match t
            :sort nil
            :action (lambda (target)
                      (progn
                        (setq cfw:org-icalendars `(,(concat org-directory target ".org")))
                        (cfw:open-org-calendar)))))
