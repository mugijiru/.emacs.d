(define-auto-insert "\\.vue$" "template.vue")

(el-get-bundle vue-mode)
(el-get-bundle hlissner/emacs-pug-mode)
(defun my/css-mode-hook ()
  ;; vue-mode では scss は css-mode が適用される
  ;; https://github.com/AdamNiederer/vue-mode/blob/031edd1f97db6e7d8d6c295c0e6d58dd128b9e71/vue-mode.el#L63
  (setq-local flycheck-checker 'css-stylelint)
  (rainbow-mode 1))

(defun my/vue-mode-hook ()
  (display-line-numbers-mode t)
  (lsp)
  (flycheck-mode 1))

(add-hook 'css-mode-hook 'my/css-mode-hook)
(add-hook 'vue-mode-hook 'my/vue-mode-hook)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define css-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
