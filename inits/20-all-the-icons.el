(el-get-bundle all-the-icons)
(require 'all-the-icons)
;; (all-the-icons-install-fonts) unless installed

(defun my/insert-all-the-icons-code (family)
  (let* ((candidates (all-the-icons--read-candidates-for-family family))
         (prompt     (format "%s Icon: " (funcall (all-the-icons--family-name family))))
         (selection  (completing-read prompt candidates nil t)))
    (insert "(all-the-icons-" (symbol-name family) " \"" selection "\")")))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define all-the-icons-hydra (:separator "-" :title "All the icons" :exit t :quit-key "q")
    ("Insert"
     (("a" all-the-icons-insert-alltheicon  "All the icons")
      ("f" all-the-icons-insert-fileicon    "File icons")
      ("F" all-the-icons-insert-faicons     "FontAwesome")
      ("m" all-the-icons-insert-material    "Material")
      ("o" all-the-icons-insert-octicon     "Octicon")
      ("w" all-the-icons-insert-wicon       "Weather")
      ("*" all-the-icons-insert             "All"))

     "Lisp code"
     (("la" (my/insert-all-the-icons-code 'alltheicon)  "All the icons")
      ("lf" (my/insert-all-the-icons-code 'fileicon)    "File icons")
      ("lF" (my/insert-all-the-icons-code 'faicon)      "FontAwesome")
      ("lm" (my/insert-all-the-icons-code 'material)    "Material")
      ("lo" (my/insert-all-the-icons-code 'octicon)     "Octicon")
      ("lw" (my/insert-all-the-icons-code 'wicon)       "Weather")))))
