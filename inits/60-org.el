(el-get-bundle org-mode :checkout "release_9.3.6") ;; from Git. because melpa cannot resolve dependencies.
(el-get-bundle org-export-blocks-format-plantuml)
(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (ruby . t)))
(setq org-directory (expand-file-name "~/Documents/org/"))

;; org-mode のリンク先が xlsx の時に numbers を開くようにした
;; default は内部的には open コマンドが使われる
(add-to-list 'org-file-apps '("\\.xlsx?\\'" . default))

(setq org-todo-keywords
      '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))

;; DONEの時刻を記録
(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")

;; タスク管理系
(setq my/org-tasks-directory (concat org-directory "tasks/"))

;; ob-async
(el-get-bundle ob-async)
(require 'ob-async)
(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images) ;; org-babel-execute 後に画像を再表示
