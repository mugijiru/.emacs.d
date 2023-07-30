(defun my/emacs-lisp-mode-hook ()
  (display-line-numbers-mode 1)
  (origami-mode 1)
  (company-mode 1)
  (smartparens-mode 1)
  (turn-on-smartparens-strict-mode))

(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-mode-hook)

(defun my/insert-all-the-icons-code (family)
  (interactive)
  (let* ((candidates (all-the-icons--read-candidates-for-family family))
         (prompt     (format "%s Icon: " (funcall (all-the-icons--family-name family))))
         (selection  (completing-read prompt candidates nil t)))
    (insert "(all-the-icons-" (symbol-name family) " \"" selection "\")")))

(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-fileicon "elisp") " Emacs Lisp"))
    ("Describe"
     (("F" counsel-describe-function "Function")
      ("V" counsel-describe-variable "Variable"))

     "Insert Icon Code"
     (("@a" (my/insert-all-the-icons-code 'alltheicon) "All the icons")
      ("@f" (my/insert-all-the-icons-code 'fileicon)   "File icons")
      ("@F" (my/insert-all-the-icons-code 'faicon)     "FontAwesome")
      ("@m" (my/insert-all-the-icons-code 'material)   "Material")
      ("@o" (my/insert-all-the-icons-code 'octicon)    "Octicon")
      ("@w" (my/insert-all-the-icons-code 'wicon)      "Weather")))))
