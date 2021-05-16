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

;; タスク管理系
(setq my/org-tasks-directory           (concat org-directory "tasks/"))

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
