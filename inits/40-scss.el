(el-get-bundle rainbow-mode)

(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))

(defun my/scss-mode-hook ()
  (flycheck-mode 1)

  (setq-local lsp-prefer-flymake nil)
  (lsp)
  (lsp-ui-mode -1)

  (smartparens-strict-mode 1)

  ;; lsp-ui とかより後に設定しないと上書きされるのでここに移動した
  (setq-local flycheck-checker 'scss-stylelint)
  (setq-local flycheck-check-syntax-automatically '(save new-line idle-change))

  (company-mode 1)
  (display-line-numbers-mode 1)

  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)

(defun my/replace-var (point mark)
  (interactive "r")
  (let* ((str (buffer-substring point mark))
         (cmd (concat "fetch-color-var '" str "'"))
         (response (shell-command-to-string cmd)))
    (delete-region point mark)
    (insert response)))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define scss-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
