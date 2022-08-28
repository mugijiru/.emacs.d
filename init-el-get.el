(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes") )

;; el-get のバージョンロック機構の導入
(el-get-bundle tarao/el-get-lock)
(require 'cl)
(el-get-lock)

(defun my/el-get-auto-update (package)
  (let ((el-get-default-process-sync t)
        (old-checksum (my/el-get-lock-checksum package)))
    (el-get-lock-checkout "el-get")
    (sit-for 10) ;; el-get がなんか読み込まれてるので待ってみる
    (el-get-lock-checkout package)
    (el-get-update package)
    (let ((new-checksum (my/el-get-lock-checksum package)))
      (unless (string= old-checksum new-checksum)
        (let* ((compare (concat old-checksum "..." new-checksum))
               (recipe (ignore-errors (el-get-package-def package)))
               (pkgname (plist-get recipe :pkgname))
               (commit-message-body (concat "https://github.com/" pkgname "/compare/" compare)))
          (write-region commit-message-body nil "/tmp/commit-message-body.txt"))))))

(defun my/el-get-lock-checksum (package)
  (let ((versions (cdr el-get-lock-package-versions))
        (package-sym (intern package)))
    (cadr (alist-get package-sym (cdr el-get-lock-package-versions)))))
