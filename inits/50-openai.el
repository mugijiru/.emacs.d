(el-get-bundle emacs-openai)

(setq openai-user (plist-get (nth 0 (auth-source-search :host "api.openai.com")) :user))
(setq openai-key (funcall (plist-get (nth 0 (auth-source-search :host "api.openai.com")) :secret)))

(defvar-local my/openai-result nil)

(defun my/openai-completion-from-prompt (input)
  (interactive "sText: ")
  (openai-completion input
                     (lambda (data)
                       (let* ((choices (openai--data-choices data))
                              (result (openai--get-choice choices)))
                         (message "result: %s" result))) :max-tokens 2000))

(defun my/openai-observe (buf end)
  (cond
   (my/openai-result
    (save-current-buffer
      (set-buffer (get-buffer buf))
      (goto-char end)
      (insert my/openai-result)
      (setq my/openai-result nil)
      (my/openai-stop-observe)))
   (t
    nil)))

(defvar my/openai-observe-timer nil)

(defun my/openai-start-observe (buf end)
  (setq my/openai-observe-timer
        (run-with-idle-timer 0.5 t 'my/openai-observe buf end)))

(defun my/openai-stop-observe ()
  (cancel-timer my/openai-observe-timer))

(defun my/openai-completion-from-region (begin end)
  (interactive "r")
  (my/openai-start-observe (current-buffer) end)
  (openai-completion (buffer-substring-no-properties begin end)
                     (lambda (data)
                       (let* ((choices (openai--data-choices data))
                              (result (openai--get-choice choices)))
                         (setq my/openai-result result)))
                     :max-tokens 4000)
  (deactivate-mark t))
