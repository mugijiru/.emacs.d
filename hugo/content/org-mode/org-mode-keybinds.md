+++
title = "org-mode 関係の keybinds"
draft = false
weight = 14
+++

## 概要 {#概要}

ここでは org-mode 関係のキーバインド設定を書いている。キーバインドというか Hydra の設定になっているが。

Hydra を定義しておくことで様々なキーバインドを忘れることができるし左手小指を酷使しなくて済むので便利ということで Hydra で設定している。


## major-mode-hydra {#major-mode-hydra}

major-mode-hydra で、org-mode のファイルを開いている時によく使いそうなコマンドのキーバインドを定義している

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-fileicon "org") " Org commands"))
    ("Navigation"
     (("H" counsel-outline        "Outline")
      ("B" org-mark-ring-goto     "Back link")
      ("," org-cycle-agenda-files "Agenda Cycle"))

     "Insert"
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
      ("'" org-edit-special     "Edit")
      ("Q" org-set-tags-command "Tag"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("C" org-columns                  "Columns")
      ("O" org-global-cycle             "Toggle open")
      ("D" my/org-clock-toggle-display  "Toggle Display"))

     "Task"
     (("s" org-schedule         "Schedule")
      ("d" org-deadline         "Deadline")
      ("t" my/org-todo          "TODO state")
      ("c" org-toggle-checkbox  "Toggle checkbox")
      ("I" org-clock-in         "Clock In")
      ("O" org-clock-out        "Clock Out")
      ("E" org-set-effort       "Effort")
      ("R" org-clock-report     "Report")
      ("p" org-pomodoro         "Pomodoro"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval")
      ("x" org-babel-tangle "Export SRC"))

     "Trello"
     (("K" org-trello-mode "On/Off" :toggle org-trello-mode)
      ("k" (if org-trello-mode
               (org-trello-hydra/body)
             (message "org-trello-mode is not enabled")) "Menu"))))

  (major-mode-hydra-define org-agenda-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-octicon "calendar") " Agenda commands"))
    ("Edit"
     (("a" org-agenda-archive  "Archive")
      ("r" org-agenda-refile   "Refile")
      ("t" org-agenda-todo     "TODO")
      ("Q" org-agenda-set-tags "Tag")
      ("s" org-agenda-schedule "Schedule")
      ("d" org-agenda-deadline "Deadline"))

     "Filter"
     (("C" org-agenda-filter-by-category     "Category")
      ("T" org-agenda-filter-by-tag          "Tag")
      ("H" org-agenda-filter-by-top-headline "Headline")
      ("E" org-agenda-filter-by-effort       "Effort")
      ("R" org-agenda-filter-by-regex        "Regex")
      ("z" org-agenda-filter-remove-all      "Clear"))

     "Priority"
     ((">" org-agenda-priority-up   "Up")
      ("<" org-agenda-priority-down "Down")
      ("," org-agenda-priority      "Set"))

     "Clock"
     (("i" org-agenda-clock-in     "In")
      ("o" org-agenda-clock-out    "Out")
      ("p" org-pomodoro            "Pomodoro")
      ("e" org-agenda-set-effort   "Set Effort")
      ("g" org-agenda-clock-goto   "Go to")
      ("x" org-agenda-clock-cancel "Cancel")))))
```

合わせて agenda 用の major-mode-hydra も定義しているが、こちらは情報をまだまとめていない……。


## 検索用 Hydra {#検索用-hydra}

pretty-hydra を使って org のドキュメントを検索するための各コマンドを叩けるようにしている。これは後述の `global-org-hydra` から呼び出す想定である

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    org-search-hydra
    ( :separator "-"
      :color teal
      :foreign-key warn
      :title (concat (nerd-icons-mdicon "nf-md-note_search") " Org Search")
      :quit-key "q")
    ("Heading"
     (("h" org-search-view                  "Heading")
      ("o" counsel-org-goto-all             "Outline"))
     "RipGrep"
     (("j" my/org-search-string-in-journals "Journal")
      ("/" my/org-search-string             "All")
      ("P" my/org-search-in-pointers        "Pointers")))))
```


## Global な Hydra {#global-な-hydra}

pretty-hydra を使って Global に使える org-mode のコマンドを叩けるようにしている

```emacs-lisp
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
      ("t" my/org-tags-view-only-todo "Tagged Todo")
      ("/" org-search-hydra/body      "Search"))

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

     "Roam"
     ((";" org-roam-hydra/body "Menu"))

     "Pomodoro"
     (("p" org-pomodoro "Pomodoro")))))
```


## その他 {#その他}

org-agenda 用の Hydra も用意しておいた方が良さそうだなというのが最近の実感。同じコマンド体系で操作できるようにしておいたら考えることが減って楽。
