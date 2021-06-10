(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/dash"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/el-get/org-mode"))
(require 'ert)
(require 'org)
(require 'dash)

(load (expand-file-name "~/.emacs.d/inits/68-my-org-commands.el"))

(ert-deftest test:my/org-todo-keyword-strings ()
  "Test of `my/org-todo-keyword-strings'."
  (setq org-todo-keywords
        '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
  (should (equal '("TODO" "DOING" "WAIT" "DONE" "SOMEDAY")
                 (my/org-todo-keyword-strings))))
