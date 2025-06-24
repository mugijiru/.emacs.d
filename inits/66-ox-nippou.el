(el-get-bundle ox-nippou)

(setopt ox-nippou-journal-directory (expand-file-name "journal" org-roam-directory))
(setopt ox-nippou-no-tasks-string ":pear:")
(setopt ox-nippou-todo-state-mapping '(("todo" . ("TODO"))
                                       ("doing" . ("DOING" "WAIT"))
                                       ("done" . ("DONE"))))
