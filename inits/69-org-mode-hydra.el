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
      ("O" org-global-cycle "Toggle open")
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
     (("e" org-babel-confirm-evaluate "Eval")
      ("x" org-babel-tangle "Export SRC"))

     "Roam"
     ((";" org-roam-hydra/body "Menu"))

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
     (("a" org-agenda                 "Agenda")
      ("c" counsel-org-capture        "Capture")
      ("l" org-store-link             "Store link")
      ("J" org-journal-new-entry      "Journal")
      ("R" my/org-reviews-execute     "Review")
      ("t" my/org-tags-view-only-todo "Tagged Todo"))

     "Calendar"
     (("F" org-gcal-fetch "Fetch Calendar")
      ("C" my/open-calendar "Calendar")
      ("A" my/org-refresh-appt "Appt"))

     "Clock"
     (("i" org-clock-in       "In")
      ("o" org-clock-out      "Out")
      ("r" org-clock-in-last  "Restart")
      ("x" org-clock-cancel   "Cancel")
      ("j" org-clock-goto     "Goto"))

     "Search"
     (("H" org-search-view "Heading")
      ("f" org-roam-find-file "Roam"))

     "Pomodoro"
     (("p" org-pomodoro "Pomodoro")))))
