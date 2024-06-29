(setq org-outline-path-complete-in-steps nil)

(setq org-refile-use-outline-path 'file)

(defun my/reset-org-refile-targets ()
  (setq org-refile-targets `((,(org-journal--get-entry-path) :regexp . "Tasks")
                             (,(concat org-directory "tasks/projects.org") :level . 1)
                             (,(concat org-directory "tasks/pointers.org") :level . 1)
                             (,(concat org-directory "tasks/someday.org") :level . 1))))

(my/reset-org-refile-targets)
