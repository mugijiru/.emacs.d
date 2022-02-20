(progn
  (load (expand-file-name "~/.emacs.d/init-el-get.el"))
  (let ((obsolute-packages '())
        (cannot-get-url-packages '())
        (cannot-get-hash-packages '())
        (not-installed-packages '())
        (el-get-default-process-sync t)
        (versions (cdr el-get-lock-package-versions)))
    (dolist (version versions)
      (let ((package (replace-regexp-in-string "\\\\\\\." "\\\." (symbol-name (car version))))
            (checksum (plist-get (cdr version) :checksum)))
        (princ package)
        (princ " checking...")
        (if (el-get-package-installed-p package)
            (progn
              (let* ((recipe (ignore-errors (el-get-package-def package)))
                     (type (plist-get recipe :type))
                     (branch (plist-get recipe :branch))
                     (tag (plist-get recipe :checkout))
                     (pkgname (plist-get recipe :pkgname))
                     (url (if (eq type 'github)
                              (concat "git://github.com/" pkgname ".git")
                            (plist-get recipe :url))))
                (if url
                    (progn
                      (let* ((grep-regexp-prefix "refs/")
                             (grep-options (if branch
                                               (list "-e" (concat grep-regexp-prefix "heads/" branch))
                                             (if tag
                                                 (list "-e" (concat grep-regexp-prefix "tags/" tag "^{}"))
                                               (list "-e" (concat grep-regexp-prefix "heads/master") "-e" (concat grep-regexp-prefix "heads/main")))))
                             (command-list (append (list "git" "ls-remote" url "|" "grep") grep-options))
                             (command (mapconcat #'shell-quote-argument command-list " "))
                             (result (shell-command-to-string command))
                             (hash (if (>= (string-width result) 40)
                                       (substring result 0 40)
                                     nil)))
                        (if hash
                            (if (string-equal checksum hash)
                                (progn
                                  (princ "no updates."))
                              (princ (concat "update found! " checksum "..." hash))
                              (add-to-list 'obsolute-packages package))
                          (add-to-list 'cannot-get-hash-packages package)
                          (princ "cannot get hash"))))
                  (add-to-list 'cannot-get-url-packages package)
                  (princ "cannot get url."))))
          (add-to-list 'not-installed-packages package)
          (princ "not installed.")))
      (princ "\n"))
    (message "## obsolute packages ##")
    (dolist (package obsolute-packages)
      (message package))
    (message "\n## not installed packages ##")
    (dolist (package not-installed-packages)
      (message package))
    (message "\n## cannot get hash packages ##")
    (dolist (package cannot-get-hash-packages)
      (message package))
    (message "\n## cannot get url packages ##")
    (dolist (package cannot-get-url-packages)
      (message package))))
