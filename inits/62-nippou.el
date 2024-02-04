(my/load-config "my-nippou-config")

(defun my/org-nippou-files ()
  (let* ((dir my/org-tasks-directory)
         (cmd (format "find \"%s\" -name '*.org' -or -name '*.org_archive'" dir))
         (result (shell-command-to-string cmd))
         (file-names (split-string result "\n")))
    (-remove (lambda (file-name) (string= "" file-name))
             file-names)))

(defun my/org-nippou-targets ()
  (-concat (my/org-nippou-files) my/org-nippou-additional-files))

(defun my/nippou-query ()
  (interactive)
  (org-ql-search
    (my/org-nippou-targets)
    "todo:TODO,DOING,WAIT,DONE ts:on=today"
    :title "日報"
    :super-groups '((:auto-group))))
