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

(custom-set-variables
 '(org-journal-dir (concat org-directory "journal/"))
 '(org-journal-file-format "%Y%m%d.org")
 '(org-journal-date-format "%d日(%a)")
 '(org-journal-enable-agenda-integration nil)
 '(org-journal-carryover-items "TODO={TODO\\|DOING\\|WAIT}"))

(with-eval-after-load 'org-journal
  (add-to-list 'org-journal-after-header-create-hook 'my/reset-org-refile-targets))
