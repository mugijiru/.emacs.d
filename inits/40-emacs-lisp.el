(el-get-bundle paredit)
(defun my/emacs-lisp-mode-hook ()
  (display-line-numbers-mode 1)
  (company-mode 1)
  (paredit-mode 1))
(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-mode-hook)

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode (:quit-key "q" :title (concat (all-the-icons-fileicon "elisp") " Emacs Lisp"))
    ("Describe"
     (("F" counsel-describe-function "Function")
      ("V" counsel-describe-variable "Variable")))))
