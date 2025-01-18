+++
title = "el-get 関係の自前関数"
draft = false
+++

el-get と el-get-lock を使った関数を用意している

説明は面倒なので今のところはとりあえず tangle するコードだけ置いとくね

```emacs-lisp
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
               (type (plist-get recipe :type))
               (pkgname (plist-get recipe :pkgname))
               (url (plist-get recipe :url))
               (title (concat "Update " package))
               (body (cond
                      ((eq type 'github)
                       (concat "https://github.com/" pkgname "/compare/" compare))
                      ((string-match (concat "^" "https://codeberg.org/") url)
                       (concat (substring url 0 (- (length url) 4)) "/compare/" compare))
                      (t
                       (concat "compare: " compare))))
               (commit-message (concat title "\n\n" body)))
          (write-region commit-message nil "/tmp/commit-message.txt"))))))

(defun my/el-get-lock-checksum (package)
  (let ((versions (cdr el-get-lock-package-versions))
        (package-sym (intern package)))
    (cadr (alist-get package-sym (cdr el-get-lock-package-versions)))))
```
