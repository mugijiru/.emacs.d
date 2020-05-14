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

;; org-capture
(defvar org-capture-ical-file (concat org-directory "ical.org"))
(setq org-capture-ical-file (concat org-directory "ical.org"))

;; タスク管理系
(setq my/org-tasks-directory (concat org-directory "tasks/"))
(setq my/org-capture-review-file (concat my/org-tasks-directory "review.org"))
(setq my/org-capture-env-file (concat my/org-tasks-directory "env.org"))
(setq my/org-capture-develop-file (concat my/org-tasks-directory "develop.org"))
(setq my/org-capture-research-file (concat my/org-tasks-directory "research.org"))
(setq my/org-capture-interrupted-file (concat my/org-tasks-directory "interrupted.org"))
(setq my/org-capture-management-file (concat my/org-tasks-directory "management.org"))
(setq my/org-capture-gtd-file (concat my/org-tasks-directory "gtd.org"))

;; org-agenda の週の始まりを日曜日に
(setq org-agenda-start-on-weekday 0)

(setq org-agenda-files
      '("~/Documents/org/ical.org"
        "~/Documents/org/tasks/"))

(setq org-capture-templates
      `(("g" "GTDにエントリー" entry
         (file+headline ,my/org-capture-gtd-file "Inbox")
         "** TODO %?\n\t")
        ("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")
        ("e" "環境問題にエントリー" entry
         (file+headline ,my/org-capture-env-file "Environment")
         "** TODO %?\n\t")
        ("r" "レビューにエントリー" entry
         (file+headline ,my/org-capture-review-file "Review")
         "** TODO %?\n\t")
        ("R" "調査にエントリー" entry
         (file+headline ,my/org-capture-research-file "Research")
         "** TODO %?\n\t")
        ("d" "開発タスクにエントリー" entry
         (file+headline ,my/org-capture-develop-file "Develop")
         "** TODO %?\n\t")
        ("i" "割り込みタスクにエントリー" entry ;; 参考: http://grugrut.hatenablog.jp/entry/2016/03/13/085417
         (file+headline ,my/org-capture-interrupted-file "Interrupted")
         "** %?\n\t" :clock-in t :clock-resume t)
        ("m" "管理系タスクにエントリー" entry
         (file+headline ,my/org-capture-management-file "Management")
         "** TODO %?\n\t")))

(setq org-clock-clocktable-default-properties
      '(:maxlevel 4
                 :lang "ja"
                 :scope agenda
                 :block today
                 :level 4))

(el-get-bundle org-gcal)
(require 'org-gcal)
(load "my-org-gcal-config")

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

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define org-mode (:quit-key "q" :title (concat (all-the-icons-fileicon "org") " Org commands"))
    ("Insert"
     (("l" org-insert-link "Link")
      ("t" org-insert-todo-heading "Todo")
      ("h" org-insert-heading-respect-content "Heading")
      ("S" org-insert-structure-template "Snippet"))

     "Edit"
     (("a" org-archive-subtree "Archive"))

     "View"
     (("N" org-toggle-narrow-to-subtree "Toggle Subtree")
      ("D" my/org-clock-toggle-display "Toggle Display"))

     "Task"
     (("s" org-schedule "Schedule")
      ("d" org-deadline "Deadline")
      ("T" org-todo "Change state"))

     "Clock"
     (("i" org-clock-in "In")
      ("o" org-clock-out "Out"))

     "Babel"
     (("e" org-babel-confirm-evaluate "Eval"))

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
      ("c" org-capture "Capture")
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
      ("r" org-clock-report "Report")))))

(defun my/org-tags-view-only-todo ()
  (interactive)
  (org-tags-view t))

(load "my-notify-slack-config")
(defun my/notify-slack (channel text)
  (start-process "my/org-clock-slack-notifier" "*my/org-clock-slack-notifier*" "my-slack-notifier" channel text))

(defun my/notify-slack-times (text)
  (my/notify-slack my/notify-slack-times-channel text))

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
