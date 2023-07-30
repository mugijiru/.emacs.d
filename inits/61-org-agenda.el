(el-get-bundle org-super-agenda)

(setq org-agenda-start-on-weekday 0)

(setq org-agenda-span 'day)

(setq org-agenda-files
      '("~/Documents/org/ical.org"
        "~/Documents/org/tasks/"))

(setq org-agenda-use-time-grid nil)

(setq org-agenda-block-separator "------------------------------")

(org-super-agenda-mode 1)

(setq my/org-agenda-calendar-files '())

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
    (alltodo ""
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "予定作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past :not (:category "Private")))
                                           (:name "予定が過ぎてる作業" :and (:scheduled past :not (:category "Private")))
                                           (:name "今日〆切の作業" :and (:deadline today :not (:category "Private")))
                                           (:name "今日予定の作業" :and (:scheduled today :not (:category "Private")))
                                           (:name "今後1週間の作業" :and (:and
                                                                          (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                      :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                          :not (:category "Private")))
                                           (:discard (:anything t))))))
    (tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend"
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "今日の作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/next-actions.org"
                                    "~/Documents/org/tasks/reviews.org"))
                (org-super-agenda-groups '((:name "仕掛かり中" :todo "DOING")
                                           (:name "TODO" :and (:todo "TODO" :not (:category "レビュー")))
                                           (:name "待ち" :todo "WAIT")
                                           (:discard (:anything t))))))
    (tags-todo "Weekday-Finish|Daily"
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
                (org-super-agenda-groups '((:name "仕掛かり中" :and (:todo "DOING" :not (:category "レビュー") :not (:category "開発")))
                                           (:name "TODO" :and (:todo "TODO" :not (:category "レビュー") :not (:category "開発")))
                                           (:name "待ち" :and (:todo "WAIT" :not (:category "レビュー") :not (:category "開発")))
                                           (:discard (:anything t))))))
    (alltodo ""
               ((org-agenda-prefix-format " ")
                (org-agenda-overriding-header "予定作業")
                (org-habit-show-habits nil)
                (org-agenda-span 'day)
                (org-agenda-todo-keyword-format "-")
                (org-overriding-columns-format "%25ITEM %TODO")
                (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past :category "Private"))
                                           (:name "予定が過ぎてる作業" :and (:scheduled past :category "Private"))
                                           (:name "今日〆切の作業" :and (:deadline today :category "Private"))
                                           (:name "今日予定の作業" :and (:scheduled today :category "Private"))
                                           (:name "今後1週間の作業" :and (:and
                                                                          (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                      :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                          :category "Private"))
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
    (tags-todo "-Emacs-org-Env-Hugo&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
  ("pN" "No major tags"
   ((tags-todo "-Emacs-org-Env-Hugo-Kibela-Develop-ReviewLister-HouseWork-Private&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))
  ("P" "Pointers"
   ((todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))
    (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))))
  ("X" "Finished"
   ((todo "DONE"    ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                         "~/Documents/org/tasks/inbox.org"
                                         "~/Documents/org/tasks/reviews.org"
                                         "~/Documents/org/tasks/next-actions.org"))))
    (todo "SOMEDAY" ((org-agenda-files '("~/Documents/org/tasks/projects.org"
                                         "~/Documents/org/tasks/inbox.org"
                                         "~/Documents/org/tasks/reviews.org"
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
