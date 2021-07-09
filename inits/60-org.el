(el-get-bundle org-mode :checkout "release_9.3.6")

(el-get-bundle org-export-blocks-format-plantuml)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (sql . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (js . t)
                               (ruby . t)))

(setq org-directory (expand-file-name "~/Documents/org/"))

(add-to-list 'org-file-apps '("\\.xlsx?\\'" . default))

(setq org-todo-keywords
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))

(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")

(setq my/org-tasks-directory (concat org-directory "tasks/"))

;; ob-async
(el-get-bundle ob-async)
(require 'ob-async)

(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
