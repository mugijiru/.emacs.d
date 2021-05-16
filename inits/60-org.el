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


(el-get-bundle ob-async)
(require 'ob-async)
(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images) ;; org-babel-execute 後に画像を再表示

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
