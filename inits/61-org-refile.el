(setq org-outline-path-complete-in-steps nil)

(setq org-refile-use-outline-path 'file)

(setq org-refile-targets `((,(concat org-directory "tasks/projects.org") :level . 1)
                           (,(concat org-directory "tasks/pointers.org") :level . 1)
                           (,(concat org-directory "work/scrum/impediments.org") :level . 3)
                           (,(concat org-directory "tasks/next-actions.org") :regexp . "today")
                           (,(concat org-directory "tasks/next-actions.org") :regexp . "C-")
                           (,(concat org-directory "private/2020_summary.org") :level . 2)
                           (,(concat org-directory "tasks/shopping.org") :level . 1)
                           (,(concat org-directory "tasks/someday.org") :level . 1)))
