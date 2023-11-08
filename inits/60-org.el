(el-get-bundle org-mode)

(setq org-directory (expand-file-name "~/Documents/org/"))

(setq my/org-tasks-directory (concat org-directory "tasks/"))

(setq org-todo-keywords
      '((sequence "TODO" "EXAMINATION(e)" "READY(r)" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))

(setq org-log-done 'time)
(setq org-log-into-drawer "LOGBOOK")

(custom-set-variables
  '(org-complete-tags-always-offer-all-agenda-tags t))

(with-eval-after-load 'org
  (require 'org-protocol)
  (add-to-list 'org-modules 'org-protocol)
  (add-to-list 'org-file-apps '("\\.xlsx?\\'" . default)))

(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (sql . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (js . t)
                               (org . t)
                               (ruby . t)))

(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)

(el-get-bundle ob-async)
(require 'ob-async)

(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))

(custom-set-variables
 '(org-id-link-to-org-use-id t)
 '(org-archive-location "./archives/%s_archive::"))

(defun my/org-refresh-appt-on-complete-habit (args)
  "習慣タスクを完了した時に Appt を refresh する"
  (let* ((element (org-element-at-point))
         (style (org-element-property :STYLE element))
         (to (plist-get args :to)))
    (if (and (string= style "habit") (string= "TODO" to))
        (my/org-refresh-appt))))

(add-hook 'org-trigger-hook 'my/org-refresh-appt-on-complete-habit)

(defun my/org-mode-map-override-windmove-mode-map ()
  (let ((oldmap windmove-mode-map)
        (newmap (make-sparse-keymap)))
    (make-local-variable 'minor-mode-overriding-map-alist)
    (add-to-list 'minor-mode-overriding-map-alist `(windmove-mode . ,newmap))

    (add-hook 'org-shiftup-final-hook 'windmove-up)
    (add-hook 'org-shiftleft-final-hook 'windmove-left)
    (add-hook 'org-shiftdown-final-hook 'windmove-down)
    (add-hook 'org-shiftright-final-hook 'windmove-right)))

(defun my/org-mode-hook ()
  (my/org-mode-map-override-windmove-mode-map)

  ;; http://yitang.uk/2022/07/05/move-between-window-using-builtin-package/
  (define-key org-read-date-minibuffer-local-map (kbd "<left>") (lambda () (interactive) (org-eval-in-calendar '(calendar-backward-day 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<right>") (lambda () (interactive) (org-eval-in-calendar '(calendar-forward-day 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<up>") (lambda () (interactive) (org-eval-in-calendar '(calendar-backward-week 1))))
  (define-key org-read-date-minibuffer-local-map (kbd "<down>") (lambda () (interactive) (org-eval-in-calendar '(calendar-forward-week 1)))))

(add-hook 'org-mode-hook 'my/org-mode-hook)

(with-eval-after-load 'org-mode
  (my/org-mode-map-override-windmove-mode-map))
