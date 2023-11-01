(el-get-bundle org-journal)

(custom-set-variables
 '(org-journal-dir (concat org-directory "journal/"))
 '(org-journal-file-format "%Y%m%d.org")
 '(org-journal-date-format "%d日(%a)")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-carryover-items "TODO={TODO\\|DOING\\|WAIT}"))
