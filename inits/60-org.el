(el-get-bundle org-mode :checkout "release_9.3.6") ;; from Git. because melpa cannot resolve dependencies.
(el-get-bundle org-export-blocks-format-plantuml)
(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (ruby . t)))

(setq org-directory (expand-file-name "~/Documents/org/"))

;; フッターなくしたり
(setq org-export-html-footnotes-section "")
(setq org-export-html-footnote-format "")
(setq org-export-with-footnotes nil)
(setq org-export-with-creator nil)
(setq org-export-with-author nil)
(setq org-html-validation-link nil)

;; for seesaa blog settings
(setq org-export-author-info nil)
(setq org-export-email-info nil)
(setq org-export-creator-info nil)
(setq org-export-time-stamp-file nil)
(setq org-export-with-timestamps nil)
(setq org-export-with-section-numbers nil)
(setq org-export-with-sub-superscripts nil)

;;; Table of Contents を出さない
(setq org-export-with-toc nil)

;;; h1でサイト名出さない
(setq org-export-html-preamble nil)
(setq org-html-preamble nil)

;;; *bold* とか /italic/ とか _underline_ とかを<b>とかにしないようにする
(setq org-export-with-emphasize nil)

;; デフォは日本語設定
(setq org-export-default-language "ja")

;; org-mode のリンク先が xlsx の時に numbers を開くようにした
;; default は内部的には open コマンドが使われる
(add-to-list 'org-file-apps '("\\.xlsx?\\'" . default))

(setq org-todo-keywords
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE" "SOMEDAY(s)")))

(el-get-bundle org-pomodoro)

;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))

;; タスク管理系
(setq my/org-tasks-directory (concat org-directory "tasks/"))
(setq my/org-capture-interrupted-file (concat my/org-tasks-directory "interrupted.org"))
(setq my/org-capture-gtd-file (concat my/org-tasks-directory "gtd.org"))
(setq my/org-capture-pointers-file (concat my/org-tasks-directory "pointers.org"))
(setq my/org-capture-impediments-file (concat org-directory "work/scrum/impediments.org"))
(setq my/org-capture-memo-file (concat org-directory "memo.org"))


;; org-agenda の週の始まりを日曜日に
(setq org-agenda-start-on-weekday 0)

(setq org-agenda-files
      '("~/Documents/org/ical.org"
        "~/Documents/org/tasks/"))

(setq org-capture-templates
      `(("g" "GTD Inbox にエントリー" entry
         (file+headline ,my/org-capture-gtd-file "Inbox")
         "** TODO %?\n\t")
        ("m" "Memoにエントリー" entry
         (file+headline ,my/org-capture-memo-file "未分類")
         "*** %?\n\t")
        ("p" "Pointersにエントリー" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %?\n\t")
        ("i" "割り込みタスクにエントリー" entry ;; 参考: http://grugrut.hatenablog.jp/entry/2016/03/13/085417
         (file+headline ,my/org-capture-interrupted-file "Interrupted")
         "** %?\n\t" :clock-in t :clock-resume t)
        ("I" "障害リストにエントリー" entry
         (file+headline ,my/org-capture-impediments-file "Impediments")
         "** TODO %?\n\t")
        ("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")))

(setq org-clock-clocktable-default-properties
      '(:maxlevel 10
                 :lang "ja"
                 :scope agenda-with-archives
                 :block today
                 :level 4))

(el-get-bundle persist) ;; org-gcal に必要
(el-get-bundle org-gcal)
(require 'org-gcal)
(my/load-config "my-org-gcal-config")

(el-get-bundle ob-async)
(require 'ob-async)
(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/.emacs.d/el-get/plantuml-mode/plantuml.jar")))
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images) ;; org-babel-execute 後に画像を再表示

(defun my/org-clock-toggle-display ()
  (interactive)
  (if org-clock-overlays
      (org-clock-remove-overlays)
    (org-clock-display)))

(defun my/org-todo ()
  (interactive)
  (ivy-read "Org todo: "
            org-todo-keywords-for-agenda
            :require-match t
            :sort nil
            :action (lambda (keyword)
                      (org-todo keyword))))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-fileicon "org") " Org commands"))
    ("Insert"
     (("l" org-insert-link                     "Link")
      ("T" org-insert-todo-heading             "Todo")
      ("h" org-insert-heading-respect-content  "Heading")
      ("P" org-set-property                    "Property")
      ("S" org-insert-structure-template       "Snippet"))

     "Edit"
     (("a" org-archive-subtree  "Archive")
      ("r" org-refile           "Refile")
      ("Q" org-set-tags-command "Tag"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("D" my/org-clock-toggle-display  "Toggle Display"))

     "Task"
     (("s" org-schedule "Schedule")
      ("d" org-deadline "Deadline")
      ("t" my/org-todo  "Change state")
      ("c" org-toggle-checkbox "Toggle checkbox"))

     "Clock"
     (("i" org-clock-in  "In")
      ("o" org-clock-out "Out")
      ("p" org-pomodoro  "Pomodoro"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval"))

     "Trello"
     (("K" org-trello-mode "On/Off" :toggle org-trello-mode)
      ("k" (if org-trello-mode
               (org-trello-hydra/body)
             (message "org-trello-mode is not enabled")) "Menu"))

     "Agenda"
     (("," org-cycle-agenda-files "Cycle")))))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    global-org-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-fileicon "org") " Global Org commands")
                :quit-key "q")
    ("Main"
     (("a" org-agenda "Agenda")
      ("c" counsel-org-capture "Capture")
      ("l" org-store-link "Store link")
      ("t" my/org-tags-view-only-todo "Tagged Todo")
      ("F" org-gcal-fetch "Fetch Calendar")
      ("C" my/open-user-calendar "Calendar"))

     "Clock"
     (("i" org-clock-in  "In")
      ("o" org-clock-out "Out")
      ("r" org-clock-in-last "Restart")
      ("x" org-clock-cancel "Cancel")
      ("j" org-clock-goto "Goto")
      ("r" org-clock-report "Report"))

     "Search"
     (("H" org-search-view "Heading"))

     "Pomodoro"
     (("p" org-pomodoro "Pomodoro")))))

(setq org-refile-targets `((,(concat org-directory "tasks/projects.org") :level . 2)
                           (,(concat org-directory "tasks/pointers.org") :level . 1)
                           (,(concat org-directory "work/scrum/impediments.org") :level . 3)
                           (,(concat org-directory "tasks/next-actions.org") :level . 1)
                           (,(concat org-directory "tasks/daily-logs.org") :level . 5)))

(defun my/org-tags-view-only-todo ()
  (interactive)
  (org-tags-view t))

(my/load-config "my-notify-slack-config")

(setq my/notify-slack-enable-p t)

(defun my/notify-slack-toggle ()
  (interactive)
  (if my/notify-slack-enable-p
      (setq my/notify-slack-enable-p nil)
    (setq my/notify-slack-enable-p t)))

(defun my/notify-slack (channel text)
  (start-process "my/org-clock-slack-notifier" "*my/org-clock-slack-notifier*" "my-slack-notifier" channel text))

(defun my/notify-slack-times (text)
  (if my/notify-slack-enable-p
      (my/notify-slack my/notify-slack-times-channel text)))

(defun my/org-clock-in-hook ()
  (let* ((task org-clock-current-task)
         (message (format "開始: %s" task)))
    (my/notify-slack-times message)))

(defun my/org-clock-out-hook ()
  (let* ((task org-clock-current-task)
         (message (format "終了: %s" task)))
    (my/notify-slack-times message)))

(setq org-clock-in-hook 'my/org-clock-in-hook)
(setq org-clock-out-hook 'my/org-clock-out-hook)
