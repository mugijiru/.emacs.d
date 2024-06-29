(el-get-bundle org-journal)

(require 'org-journal)

(defun my/org-agenda-scope-with-yesterday-journal ()
  (let* ((agenda-files (org-agenda-files t))
         (24-hours-ago (* -60 60 24))
         (yesterday (time-add (current-time) 24-hours-ago))
         (yesterday-string (format-time-string "%Y%m%d" yesterday))
         (yesterday-journal-file-path (concat org-journal-dir yesterday-string ".org"))
         (files (append `(,yesterday-journal-file-path) agenda-files)))
    (org-add-archive-files files)))

(setopt org-journal-dir (concat org-roam-directory "journal/"))
(setopt org-journal-file-format "%Y%m%d.org")
(setopt org-journal-date-format "%d日(%a)")
(setopt org-journal-enable-agenda-integration nil)
(setopt org-journal-carryover-items "TODO={TODO\\|DOING\\|WAIT}")

(with-eval-after-load 'org-journal
  (add-to-list 'org-journal-after-header-create-hook 'my/reset-org-refile-targets))
