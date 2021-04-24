(defun my/replace-var (point mark)
  (interactive "r")
  (let* ((str (buffer-substring point mark))
         (cmd (concat "fetch-color-var '" str "'"))
         (response (shell-command-to-string cmd)))
    (delete-region point mark)
    (insert response)))

(setq my/org-document-dir (expand-file-name "~/Documents/org/"))
(defun my/create-org-document ()
  (interactive)
  (find-file-other-window my/org-document-dir))

(defun my/insert-review-requested-prs-as-string ()
  (interactive)
  (let* ((cmd (concat "review-requested-prs " my/github-organization " " my/github-repository))
         (response (shell-command-to-string cmd)))
    (insert response)))
