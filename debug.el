(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(concat user-emacs-directory "el-get/el-get")

(if (require 'el-get nil 'noerror)
    (message "el-get loaded")
  (message "el-get not found, installing now"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes") )
