(el-get-bundle org-super-agenda)

(custom-set-variables
 '(org-agenda-start-on-weekday 0))

(custom-set-variables
 '(org-agenda-span 'day))

(custom-set-variables
 '(org-agenda-files '("~/Documents/org/gcals/mugijiru.org" "~/Documents/org/tasks/")))

(custom-set-variables
 '(org-agenda-use-time-grid nil))

(custom-set-variables
 '(org-agenda-block-separator "------------------------------"))

(org-super-agenda-mode 1)

(setq my/org-agenda-calendar-files '())

(defun my/org-schedule-or-deadline ()
  (let* ((deadline (org-get-deadline-time (point)))
         (schedule (org-get-scheduled-time (point)))
         (format "%m/%d"))
    (cond
     (deadline
      (concat "[〆: " (format-time-string format deadline) "]"))
     (schedule
      (concat "[予: " (format-time-string format schedule) "]"))
     (t
      ""))))

(custom-set-variables
 '(org-agenda-custom-commands

   '(("h" . "Habits")

     ("hs" "Weekday Start"
      ((tags "Weekday&Start|Daily&Start"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今日の作業" :scheduled today)
                                         (:discard (:anything t))))))))

     ("hf" "Weekday Finish"
      ((tags "Weekday&Finish"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今日の作業" :scheduled today)
                                         (:discard (:anything t))))))))

     ("hw" "Weekly"
      ((tags "Weekly"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                         (:name "今週の作業" :scheduled today)
                                         (:discard (:anything t))))))))

     ("hh" "Holiday"
      ((tags "Weekend|Holiday|Daily"
             ((org-agenda-prefix-format "  ")
              (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
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
                   (org-agenda-prefix-format "%l%c: ")
                   (org-agenda-files `("~/Documents/org/tasks/habits.org"
                                       ,(org-journal--get-entry-path)
                                       "~/Documents/org/tasks/reviews.org"))
                   (org-super-agenda-groups '((:name "仕掛かり中" :todo "DOING" :property ("agenda-group" "journal-task"))
                                              (:name "TODO" :and (:todo "TODO" :property ("agenda-group" "journal-task")))
                                              (:name "レビュー中" :todo "DOING" :category "レビュー")
                                              (:name "レビュー待ち" :todo "WAIT" :property ("agenda-group" "journal-task"))
                                              (:name "修正待ち" :todo "WAIT" :category "レビュー")
                                              (:discard (:anything t))))))
       (alltodo ""
                ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定業務")
                 (org-habit-show-habits nil)
                 (org-agenda-span 'day)
                 (org-agenda-prefix-format "  %(my/org-schedule-or-deadline) %c: ")
                 (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                 (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past   :property ("agenda-group" "1. Work")))
                                            (:name "予定が過ぎてる作業" :and (:scheduled past  :property ("agenda-group" "1. Work")))
                                            (:name "今日〆切の作業"     :and (:deadline today  :property ("agenda-group" "1. Work")))
                                            (:name "今日予定の作業"     :and (:scheduled today :property ("agenda-group" "1. Work")))
                                            (:name "今後1週間の作業"    :and (:and
                                                                              (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                          :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                              :property ("agenda-group" "1. Work")))
                                            (:discard (:anything t))))))
       (tags-todo "Weekday-Start-Finish|Daily"
                  ((org-agenda-overriding-header "習慣")
                   (org-agenda-prefix-format "  ")
                   (org-habit-show-habits t)
                   (org-agenda-files '("~/Documents/org/tasks/habits.org"))
                   (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                              (:name "今日予定" :scheduled today)
                                              (:discard (:anything t))))))))

     ("D" "Holiday"
      ((tags-todo "-Weekday-Daily-Holiday-Weekly-Weekend&LEVEL=3"
                  ((org-agenda-prefix-format " ")
                   (org-agenda-overriding-header "休日の作業")
                   (org-habit-show-habits nil)
                   (org-agenda-prefix-format "  %c: ")
                   (org-agenda-span 'day)
                   (org-agenda-files `(,(org-journal--get-entry-path)))
                   (org-super-agenda-groups '((:name "仕掛かり中" :and (:todo "DOING" :not (:property ("agenda-group" "1. Work"))))
                                              (:name "TODO"       :and (:todo "TODO"  :not (:property ("agenda-group" "1. Work"))))
                                              (:name "待ち"       :and (:todo "WAIT"  :not (:property ("agenda-group" "1. Work"))))
                                              (:discard (:anything t))))))
       (alltodo ""
                ((org-agenda-prefix-format " ")
                 (org-agenda-overriding-header "予定作業")
                 (org-habit-show-habits nil)
                 (org-agenda-prefix-format "  %(my/org-schedule-or-deadline) %c: ")
                 (org-agenda-span 'day)
                 (org-agenda-files '("~/Documents/org/tasks/projects.org" "~/Documents/org/tasks/inbox.org"))
                 (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past   :not (:property ("agenda-group" "1. Work"))))
                                            (:name "予定が過ぎてる作業" :and (:scheduled past  :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今日〆切の作業"     :and (:deadline today  :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今日予定の作業"     :and (:scheduled today :not (:property ("agenda-group" "1. Work"))))
                                            (:name "今後1週間の作業"    :and (:and
                                                                              (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                          :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                              :not (:property ("agenda-group" "1. Work"))))
                                            (:discard (:anything t))))))
       (tags-todo "Holiday|Weekend|Daily"
                  ((org-agenda-overriding-header "習慣")
                   (org-agenda-prefix-format "  ")
                   (org-agenda-files '("~/Documents/org/tasks/habits.org"))
                   (org-super-agenda-groups '((:name "予定が過ぎてる作業" :scheduled past)
                                              (:name "今日予定の作業" :scheduled today)
                                              (:discard (:anything t))))))
       (tags-todo "LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Private")
                   (org-super-agenda-groups '((:name "Priority >= B" :and (:priority>= "B" :property ("agenda-group" "7. Private")))
                                              (:name "no priority" :and (:not (:priority>= "C") :property ("agenda-group" "7. Private")))
                                              (:discard (:anything t))))))
       (tags-todo "Emacs&LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Emacs")
                   (org-super-agenda-groups '((:priority>= "B")
                                              (:name "no priority" :not (:priority>= "C"))
                                              (:discard (:anything t))))))
       (tags-todo "Env&LEVEL=2"
                  ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                   (org-agenda-overriding-header "Env")
                   (org-super-agenda-groups '((:priority>= "B")
                                              (:name "no priority" :not (:priority>= "C"))
                                              (:discard (:anything t))))))))

     ("p" . "Projects")

     ("pA" "Projects Priority A"
      ((tags-todo "LEVEL=2&PRIORITY=\"A\"" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))

     ("pc" "Category"
      ((tags-todo "LEVEL=2&CATEGORY=\"Work\"" ((org-agenda-overriding-header "お仕事タスク")
                                               (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                               (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Housework\"" ((org-agenda-overriding-header "家事")
                                                    (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                    (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Config\"" ((org-agenda-overriding-header "設定弄り")
                                                 (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                 (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Research\"" ((org-agenda-overriding-header "調査")
                                                   (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                   (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Indie hack\"" ((org-agenda-overriding-header "個人開発")
                                                     (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                     (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Hoby\"" ((org-agenda-overriding-header "趣味関係")
                                               (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                               (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))
       (tags-todo "LEVEL=2&CATEGORY=\"Private\"" ((org-agenda-overriding-header "Private タスク")
                                                  (org-agenda-overriding-columns-format "%25ITEM %TODO")
                                                  (org-agenda-files `(,(concat org-directory "tasks/projects.org")))))))

     ("pC" "Category auto"
      ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                             (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                             (org-super-agenda-groups '((:auto-category t)))))))

     ("pg" "Agenda groups"
      ((tags-todo "LEVEL=2" ((org-agenda-overriding-header "Categories")
                             (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                             (org-super-agenda-groups '((:auto-group t)))))))

     ("pp" "Projects"
      ((tags-todo "LEVEL=2" ((org-agenda-prefix-format " ")
                             (org-agenda-overriding-header "今日のタスク")
                             (org-habit-show-habits nil)
                             (org-agenda-span 'day)
                             (org-agenda-todo-keyword-format "-")
                             (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
                             (org-super-agenda-groups (append
                                                       (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                                       '((:name "その他" :scheduled nil)
                                                         (:discard (:anything t)))))))
       (tags-todo "LEVEL=2" ((org-agenda-prefix-format " ")
                             (org-agenda-overriding-header "予定に入ってる作業")
                             (org-habit-show-habits nil)
                             (org-agenda-span 'day)
                             (org-agenda-todo-keyword-format "-")
                             (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                             (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                                        (:name "予定が過ぎてる作業" :scheduled past)
                                                        (:name "今日〆切の作業" :deadline today)
                                                        (:name "今日予定の作業" :scheduled today)
                                                        (:discard (:anything t))))))
       (tags-todo "LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))
                             (org-super-agenda-groups '((:name "待ち" :todo "WAIT")
                                                        (:name "仕掛かり中" :todo "DOING")
                                                        (:name "TODO" :todo "TODO")
                                                        (:discard (:anything t))))))))

     ("pP" "Projects without Env"
      ((alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "今日のタスク")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
                    (org-super-agenda-groups (append
                                              (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DOING" "WAIT")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                              '((:name "その他" :scheduled nil)
                                                (:discard (:anything t)))))))
       (alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "予定に入ってる作業")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files '("~/Documents/org/tasks/projects.org"))
                    (org-super-agenda-groups '((:name "〆切が過ぎてる作業" :deadline past)
                                               (:name "予定が過ぎてる作業" :scheduled past)
                                               (:name "今日〆切の作業" :deadline today)
                                               (:name "今日予定の作業" :scheduled today)
                                               (:discard (:anything t))))))
       (tags-todo "-Emacs-org-Env-Hugo&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))

     ("pw" "for Work"
      ((alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "予定/締切のある作業")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                    (org-super-agenda-groups `((:name "〆切が過ぎてる作業" :and (:deadline past :property ("agenda-group" "1. Work")))
                                               (:name "予定が過ぎてる作業" :and (:scheduled past :property ("agenda-group" "1. Work")))
                                               (:name "今日〆切の作業" :and (:deadline today :property ("agenda-group" "1. Work")))
                                               (:name "今日予定の作業" :and (:scheduled today :property ("agenda-group" "1. Work")))
                                               (:name "今後1週間の作業" :and (:and
                                                                              (:scheduled (before ,(format-time-string "%Y-%m-%d" (time-add (current-time) (days-to-time 7))))
                                                                                          :scheduled (after ,(format-time-string "%Y-%m-%d" (current-time))))
                                                                              :property ("agenda-group" "1. Work")))
                                               (:discard (:anything t))))))

       (tags-todo "LEVEL=2"
                  ((org-agenda-overriding-header "予定/締切のない作業")
                   (org-agenda-prefix-format " ")
                   (org-agenda-todo-keyword-format "-")
                   (org-agenda-files `(,(concat org-directory "tasks/projects.org")))
                   (org-super-agenda-groups '((:name "仕事 優先度B以上" :and (:deadline nil :scheduled nil :property ("agenda-group" "1. Work") :priority>= "B"))
                                              (:name "仕事 優先度なし" :and (:deadline nil :scheduled nil :property ("agenda-group" "1. Work") :not (:priority>= "C")))
                                              (:name "仕事 優先度C" :and (:deadline nil :scheduled nil :property ("agenda-group" "1. Work") :priority "C"))
                                              (:name "設定 優先度B以上" :and (:deadline nil :scheduled nil :property ("agenda-group" "3. Config") :priority>= "B"))
                                              (:name "設定 優先度なし" :and (:deadline nil :scheduled nil :property ("agenda-group" "3. Config") :not (:priority>= "C")))
                                              (:name "設定 優先度C" :and (:deadline nil :scheduled nil :property ("agenda-group" "3. Config") :priority "C"))
                                              (:discard (:anything t))))))))

     ("pN" "No major tags"
      ((tags-todo "-Emacs-org-Env-Hugo-Kibela-Develop-ReviewLister-HouseWork-Private&LEVEL=2" ((org-agenda-files '("~/Documents/org/tasks/projects.org"))))))

     ("P" "Pointers"
      ((todo "DOING" ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))
       (todo "TODO"  ((org-agenda-files '("~/Documents/org/tasks/pointers.org"))))))

     ("X" "Finished"
      ((tags "LEVEL=2" ((org-agenda-files `("~/Documents/org/tasks/projects.org"
                                            "~/Documents/org/tasks/inbox.org"
                                            "~/Documents/org/tasks/reviews.org"
                                            ,(org-journal--get-entry-path)
                                            "~/Documents/org/tasks/habits.org"))
                        (org-super-agenda-groups '((:name "Finished" :todo "DONE")
                                                   (:name "Someday" :todo "SOMEDAY")
                                                   (:discard (:anything t))))))))

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
                     (org-columns-default-format-for-agenda "%25ITEM %TODO %3PRIORITY")
                     (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
                     (org-super-agenda-groups (append
                                               (mapcar (lambda (key) `(:name ,key :and (:category ,key :todo ("DONE")))) (if (boundp 'my/nippou-categories) my/nippou-categories nil))
                                               '((:discard (:anything t :name "discard")))))))
       (alltodo "" ((org-agenda-prefix-format " ")
                    (org-agenda-overriding-header "仕掛かり中")
                    (org-habit-show-habits nil)
                    (org-agenda-span 'day)
                    (org-agenda-todo-keyword-format "-")
                    (org-agenda-files `("~/Documents/org/tasks/habits.org" ,(org-journal--get-entry-path)))
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
                                       "~/Documents/org/tasks/inbox.org")))))))))
