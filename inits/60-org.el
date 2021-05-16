(el-get-bundle org-mode :checkout "release_9.3.6") ;; from Git. because melpa cannot resolve dependencies.
(el-get-bundle org-super-agenda)
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
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))

;; DONEの時刻を記録
(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")

(el-get-bundle org-pomodoro)
(setq org-pomodoro-play-sounds nil)

;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))

;; タスク管理系
(setq my/org-tasks-directory           (concat org-directory "tasks/"))
(setq my/org-capture-interrupted-file  (concat my/org-tasks-directory "interrupted.org"))
(setq my/org-capture-inbox-file        (concat my/org-tasks-directory "inbox.org"))
(setq my/org-capture-pointers-file     (concat my/org-tasks-directory "pointers.org"))
(setq my/org-capture-impediments-file  (concat org-directory "work/scrum/impediments.org"))
(setq my/org-capture-memo-file         (concat org-directory "memo.org"))
(setq my/org-capture-sql-file          (concat org-directory "work/sql.org"))
(setq my/org-capture-shopping-file     (concat my/org-tasks-directory "shopping.org"))
(setq my/org-capture-2020-summary-file (concat org-directory "private/2020_summary.org"))


;; org-agenda の週の始まりを日曜日に
(setq org-agenda-start-on-weekday 0)

;; org-agenda のデフォルト表示を1日単位にする
(setq org-agenda-span 'day)

(setq org-agenda-files
      '("~/Documents/org/ical.org"
        "~/Documents/org/tasks/"))

;; agenda に時間の区切りを入れない
(setq org-agenda-use-time-grid nil)
(setq org-agenda-block-separator "------------------------------")
(org-super-agenda-mode 1)

(setq org-agenda-custom-commands
'(("h" . "Habits")
  ("hs" "Weekday Start"
   ((tags "Weekday&Start|Daily"
          ((org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                      (:name "今日の作業" :scheduled today)
                                      (:discard (:anything t))))))))
  ("hf" "Weekday Finish"
   ((tags "Weekday&Finish"
          ((org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                      (:name "今日の作業" :scheduled today)
                                      (:discard (:anything t))))))))
  ("hw" "Weekly"
   ((tags "Weekly"
          ((org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                      (:name "今週の作業" :scheduled today)
                                      (:discard (:anything t))))))))
  ("hh" "Holiday"
   ((tags "Weekend|Holiday|Daily"
          ((org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                      (:name "今日の作業" :scheduled today)
                                      (:discard (:anything t))))))))
  ("d" "Today"
   ((agenda "会議など"
            ((org-agenda-span 'day)
             (org-agenda-files my/org-agenda-calendar-files)))
    (tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend"
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "今日の作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                (org-super-agenda-groups '((:name "仕掛かり中" :todo "DOING")
                                           (:name "TODO" :todo "TODO")
                                           (:name "待ち" :todo "WAIT")
                                           (:discard (:anything t))))))
    (alltodo ""
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "予定作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                           (:name "予定が過ぎてる作業" :scheduled past)
                                           (:name "今日〆切の作業" :deadline today)
                                           (:name "今日予定の作業" :scheduled today)
                                           (:discard (:anything t))))))
    (tags-todo "Weekday|Daily|Weekly"
               ((org-agenda-overriding-header "習慣")
                (org-habit-show-habits t)
                (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                           (:name "今日予定" :scheduled today)
                                           (:discard (:anything t))))))))
  ("D" "Holiday"
   ((tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend"
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "休日の作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                (org-super-agenda-groups '((:name "仕掛かり中" :todo "DOING")
                                           (:name "TODO" :todo "TODO")
                                           (:name "待ち" :todo "WAIT")
                                           (:discard (:anything t))))))
    (tags-todo "Holiday|Weekend|Daily"
               ((org-agenda-overriding-header "習慣")
                (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                           (:name "今日予定の作業" :scheduled today)
                                           (:discard (:anything t))))))))
  ("p" . "Projects")
  ("pp" "Projects"
   ((alltodo "" ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "今日のタスク")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-todo-keyword-format "-")
                 (org-overriding-columns-format "%25ITEM %TODO")
                 (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                 (org-super-agenda-groups (append
                                           (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                           '((:name "その他" :scheduled nil)
                                             (:discard (:anything t)))))))
    (alltodo "" ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定に入ってる作業")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-todo-keyword-format "-")
                 (org-overriding-columns-format "%25ITEM %TODO")
                 (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                 (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                            (:name "予定が過ぎてる作業" :scheduled past)
                                            (:name "今日〆切の作業" :deadline today)
                                            (:name "今日予定の作業" :scheduled today)
                                            (:discard (:anything t))))))
    (todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))
    (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
  ("pP" "Projects without Env"
   ((alltodo "" ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "今日のタスク")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-todo-keyword-format "-")
                 (org-overriding-columns-format "%25ITEM %TODO")
                 (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                 (org-super-agenda-groups (append
                                           (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                           '((:name "その他" :scheduled nil)
                                             (:discard (:anything t)))))))
    (alltodo "" ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定に入ってる作業")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-todo-keyword-format "-")
                 (org-overriding-columns-format "%25ITEM %TODO")
                 (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                 (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                            (:name "予定が過ぎてる作業" :scheduled past)
                                            (:name "今日〆切の作業" :deadline today)
                                            (:name "今日予定の作業" :scheduled today)
                                            (:discard (:anything t))))))
    (tags-todo "-Emacs-org-Env-Hugo" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
  ("P" "Pointers"
   ((todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))
    (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))))
  ("X" "Finished"
   ((todo "DONE"    ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                         "~/Documents/org/tasks/inbox.org"
                                         "~/Documents/org/tasks/shopping.org"
                                         "~/Documents/org/tasks/next-actions.org"))))
    (todo "SOMEDAY" ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                         "~/Documents/org/tasks/inbox.org"
                                         "~/Documents/org/tasks/shopping.org"
                                         "~/Documents/org/tasks/next-actions.org"))))))

  ("z" "日報"
   ((agenda "" ((org-agenda-span 'day)
                (org-agenda-overriding-header "")
                (org-habit-show-habits nil)
                (org-agenda-format-date "## %Y/%m/%d (%a) 日報")
                (org-agenda-prefix-format " %?-12t")
                (org-agenda-files my/org-agenda-calendar-files)
                (org-super-agenda-groups
                 '((:name "会議など" :time-grid t)
                   (:discard (:anything t))))))
    (todo "DONE" ((org-agenda-prefix-format " ")
                  (org-agenda-overriding-header "対応済")
                  (org-habit-show-habits nil)
                  (org-agenda-span 'day)
                  (org-agenda-todo-keyword-format "-")
                  ;; (org-overriding-columns-format "%25ITEM %TODO %CATEGORY")
                  (org-columns-default-format-for-agenda "%25ITEM %TODO %3PRIORITY")
                  (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                  (org-super-agenda-groups (append
                                            (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DONE")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                            '((:discard (:anything t :name "discard")))))))
    (alltodo "" ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "仕掛かり中")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-todo-keyword-format "-")
                 (org-overriding-columns-format "%25ITEM %TODO")
                 (org-agenda-files '("~/Documents/org/tasks/next-actions.org"))
                 (org-super-agenda-groups (append
                                           (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                           '((:discard (:anything t :name "discard")))))))))

  ("H" "HouseWork" ((tags "HouseWork")))
  ("E" . "Env")
  ("EO" "org"
   ((tags-todo "+org"
               ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                    "~/Documents/org/tasks/inbox.org"))))))
  ("EE" "Emacs without org"
   ((tags-todo "+Emacs-org"
               ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                    "~/Documents/org/tasks/inbox.org"))))))
  ("Ee" "without Emacs"
   ((tags-todo "+Env-Emacs-org"
               ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                    "~/Documents/org/tasks/inbox.org"))))))))

(setq org-capture-templates
      `(("g" "Inbox にエントリー" entry
         (file ,my/org-capture-inbox-file)
         "* TODO %?\n\t")
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
        ("R" "2020ふりかえりにエントリー" entry
         (file+headline ,my/org-capture-2020-summary-file "Timeline")
         "** %?\n\t")
        ("s" "SQL にエントリー" entry
         (file+headline ,my/org-capture-sql-file "SQL")
         "** %?\n\t")
        ("S" "買い物リストエントリー" entry
         (file ,my/org-capture-shopping-file)
         "* TODO %?\n\t")
        ("b" "Blogネタにエントリー" entry
         (file+headline ,my/org-capture-memo-file "Blogネタ")
         "** %?\n\t")
        ("P" "Protocol" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %?\n   #+BEGIN_QUOTE\n   %i\n   #+END_QUOTE\n\n   Source: %u, [[%:link][%:description]]\n")
        ("L" "Protocol Link" entry
         (file+headline ,my/org-capture-pointers-file "Pointers")
         "** %:description\n   %:link\n   %?\n   Captured On: %U")
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
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
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
      ("." org-time-stamp                      "Timestamp")
      ("!" org-time-stamp-inactive             "Timestamp(inactive)")
      ("S" org-insert-structure-template       "Snippet"))

     "Edit"
     (("a" org-archive-subtree  "Archive")
      ("r" org-refile           "Refile")
      ("Q" org-set-tags-command "Tag"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("C" org-columns "Columns")
      ("D" my/org-clock-toggle-display  "Toggle Display"))

     "Task"
     (("s" org-schedule         "Schedule")
      ("d" org-deadline         "Deadline")
      ("t" my/org-todo          "Change state")
      ("c" org-toggle-checkbox  "Toggle checkbox"))

     "Clock"
     (("i" org-clock-in      "In")
      ("o" org-clock-out     "Out")
      ("E" org-set-effort    "Effort")
      ("R" org-clock-report  "Report")
      ("p" org-pomodoro      "Pomodoro"))

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
      ("t" my/org-tags-view-only-todo "Tagged Todo"))

     "Calendar"
     (("F" org-gcal-fetch "Fetch Calendar")
      ("C" my/open-user-calendar "Calendar"))

     "Clock"
     (("i" org-clock-in       "In")
      ("o" org-clock-out      "Out")
      ("r" org-clock-in-last  "Restart")
      ("x" org-clock-cancel   "Cancel")
      ("j" org-clock-goto     "Goto"))

     "Search"
     (("H" org-search-view "Heading"))

     "Pomodoro"
     (("p" org-pomodoro "Pomodoro")))))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-targets `((,(concat org-directory "tasks/projects.org") :level . 2)
                           (,(concat org-directory "tasks/pointers.org") :level . 1)
                           (,(concat org-directory "work/scrum/impediments.org") :level . 3)
                           (,(concat org-directory "tasks/next-actions.org") :regexp . "today")
                           (,(concat org-directory "tasks/next-actions.org") :regexp . "C-")
                           (,(concat org-directory "private/2020_summary.org") :level . 2)
                           (,(concat org-directory "tasks/shopping.org") :level . 1)
                           (,(concat org-directory "tasks/someday.org") :level . 1)))

(defun my/org-tags-view-only-todo ()
  (interactive)
  (org-tags-view t))

(defun my/org-clock-in-hook ()
  (let* ((task org-clock-current-task)
         (message (format "開始: %s" task)))
    (my/notify-slack-times message))

  (if (org-clocking-p)
      (org-todo "DOING")))

(defun my/org-clock-out-hook ()
  (let* ((task org-clock-current-task)
         (message (format "終了: %s" task)))
    (my/notify-slack-times message)))

(setq org-clock-in-hook 'my/org-clock-in-hook)
(setq org-clock-out-hook 'my/org-clock-out-hook)
