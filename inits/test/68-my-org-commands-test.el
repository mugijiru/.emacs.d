(require 'ert)

(load (expand-file-name (concat user-emacs-directory "/init-el-get.el")))
(load (expand-file-name (concat user-emacs-directory "/inits/68-my-org-commands.el")))

(ert-deftest test:my/org-todo-keyword-strings ()
  "Test of `my/org-todo-keyword-strings'."
  (setq org-todo-keywords
        '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
  (should (equal '("TODO" "DOING" "WAIT" "DONE" "SOMEDAY")
                 (my/org-todo-keyword-strings))))
