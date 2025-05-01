(setq my/org-document-dir (expand-file-name "~/Documents/org/"))
(defun my/create-org-document ()
  (interactive)
  (find-file-other-window my/org-document-dir))

(defun my/org-clock-toggle-display ()
  "各ツリーの末尾に掛かった作業時間を表示/非表示を切り替えるコマンド"
  (interactive)
  (if org-clock-overlays
      (org-clock-remove-overlays)
    (org-clock-display)))

(defun my/org-todo-keyword-strings ()
  "org-todo-keywords から装飾を省いた文字列のリストを返す関数"
  (let* ((keywords (cl-rest (cl-first org-todo-keywords)))
         (without-delimiter (cl-remove-if (lambda (elm) (string= "|" elm))
                                          keywords)))
    (mapcar (lambda (element)
              (replace-regexp-in-string "\(.+\)" "" element))
            without-delimiter)))

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

(defun my/org-refresh-appt ()
  (interactive)
  (let ((org-agenda-files (append my/org-agenda-calendar-files org-agenda-files)))
    (org-agenda-to-appt t)))

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

(defun my/insert-review-requested-prs-as-string ()
  (interactive)
  (let* ((cmd (concat "review-requested-prs " my/github-organization " " my/github-repository))
         (response (shell-command-to-string cmd)))
    (insert response)))

(with-eval-after-load 'org-agenda
  (setq my/org-agenda-files--original (copy-sequence org-agenda-files))

  (defun my/reset-org-agenda-files ()
    (interactive)
    (let ((tmp my/org-agenda-files--original))
      (setq org-agenda-files
            (cl-pushnew (org-journal--get-entry-path) tmp)))))

(defun my/org-search-string (string)
  (interactive "sSearch string: ")
  (rg string "*.org" my/org-document-dir))

(defun my/org-search-string-in-pointers (string)
  (interactive "sSearch string: ")
  (rg string "pointers.org" my/org-document-dir))

(defun my/org-search-string-in-journals (string)
  (interactive "sSearch string: ")
  (rg string "*.org" (concat my/org-document-dir "roam/journal")))
