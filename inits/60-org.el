(el-get-bundle org-mode) ;; from Git. because melpa cannot resolve dependencies.
;;(el-get-bundle org-export-blocks-format-plantuml)
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


(setq org-todo-keywords
      '((sequence "TODO" "DOING(!)" "REVIEW" "|" "DONE" "SOMEDAY(s)")))

;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))

;; タスク管理系
(setq my/org-tasks-directory (concat org-directory "tasks/"))
(setq my/org-capture-review-file (concat my/org-tasks-directory "review.org"))
(setq my/org-capture-develop-file (concat my/org-tasks-directory "develop.org"))
(setq my/org-capture-research-file (concat my/org-tasks-directory "research.org"))

(setq org-agenda-files
      '("~/Documents/org/ical.org"
        "~/Documents/org/tasks/review.org"
        "~/Documents/org/tasks/develop.org"
        "~/Documents/org/tasks/research.org"))

(setq org-capture-templates
      `(("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")
        ("r" "レビューにエントリー" entry
         (file+headline ,my/org-capture-review-file "Review")
         "** TODO %?\n\t")
        ("R" "調査にエントリー" entry
         (file+headline ,my/org-capture-research-file "Review")
         "** TODO %?\n\t")
        ("d" "開発タスクにエントリー" entry
         (file+headline ,my/org-capture-develop-file "Develop")
         "** TODO %?\n\t")))

(el-get-bundle org-gcal)
(require 'org-gcal)
(load "my-org-gcal-config")

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-mode (:quit-key "q")
    ("Insert"
     (("l" org-insert-link "Link")
      ("t" org-insert-todo-heading "Todo")
      ("h" org-insert-heading-respect-content "Heading")
      ("S" org-insert-structure-template "Snippet"))

     "Edit"
     (("a" org-archive-subtree "Archive"))

     "Task"
     (("s" org-schedule "Schedule")
      ("d" org-deadline "Deadline")
      ("T" org-todo "Change state"))

     "Clock"
     (("i" org-clock-in "In")
      ("o" org-clock-out "Out")
      ("C" org-clock-display "Display"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval"))

     "Agenda"
     (("," org-cycle-agenda-files "Cycle")))))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define global-org-hydra (:separator "-" :color teal :foreign-key warn :title "Global org commands" :quit-key "q")
    ("Main"
     (("a" org-agenda "Agenda")
      ("c" org-capture "Capture")
      ("l" org-store-link "Store link"))
     "Clock"
     (("i" org-clock-in  "In")
      ("o" org-clock-out "Out")
      ("r" org-clock-in-last "Restart")
      ("x" org-clock-cancel "Cancel")
      ("j" org-clock-goto "Goto")
      ("d" org-clock-display "Display")
      ("r" org-clock-report "Report")))))
