(el-get-bundle org-mode :checkout "release_9.3.6")

(setq org-directory (expand-file-name "~/Documents/org/"))

(setq my/org-tasks-directory (concat org-directory "tasks/"))

(setq org-todo-keywords
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))

(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")

(add-to-list 'org-file-apps '("\\.xlsx?\\'" . default))

(el-get-bundle org-export-blocks-format-plantuml)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (sql . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (js . t)
                               (ruby . t)))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

(el-get-bundle ob-async)
(require 'ob-async)

(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
