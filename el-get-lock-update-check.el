(defvar el-get-lock-update-check-verbose-flag nil)

(defun el-get-lock-update-check-print-list (title list)
  (unless (= (length list) 0)
    (if title
        (princ (concat "## " title " ##\n")))
    (dolist (list-item list)
      (princ (concat list-item "\n")))))

(defun el-get-lock-update-check-print-obsolute-only ()
  (let* ((lists (el-get-lock-update-check-assemble-lists nil))
         (obsolute-lists (alist-get 'obsolute lists)))
    (el-get-lock-update-check-print-list nil obsolute-lists)))

(defun el-get-lock-update-check-verbose-print (message)
  (if el-get-lock-update-check-verbose-flag
      (princ message)))

(defun el-get-lock-update-check-use-main-p (package)
  (let* ((recipe (ignore-errors (el-get-package-def package)))
         (type (plist-get recipe :type))
         (pkgname (plist-get recipe :pkgname))
         (url (if (eq type 'github)
                  (concat "git://github.com/" pkgname ".git")
                (plist-get recipe :url)))
         (grep-regexp-prefix "refs/")
         (grep-options (list "-e" (concat grep-regexp-prefix "heads/main")))
         (command-list (append (list "git" "ls-remote" url "|" "grep") grep-options))
         (command (mapconcat #'shell-quote-argument command-list " "))
         (result (shell-command-to-string command)))
    (if (> (string-width result) 0)
        (message "has main branch")
      (message "has not main branch"))))

(defun el-get-lock-update-check-build-git-command (recipe url)
  (let* ((branch (plist-get recipe :branch))
         (tag (plist-get recipe :checkout))
         (grep-regexp-prefix "refs/")
         (grep-options (if branch
                           (list "-e" (concat grep-regexp-prefix "heads/" branch))
                         (if tag
                             (list "-e" (concat grep-regexp-prefix "tags/" tag "^{}"))
                           (list "-e" (concat grep-regexp-prefix "heads/master") "-e" (concat grep-regexp-prefix "heads/main")))))
         (command-list (append (list "git" "ls-remote" url "|" "grep") grep-options)))
    (mapconcat #'shell-quote-argument command-list " ")))

(defun el-get-lock-update-check-get-git-hash-string (recipe url)
  (let* ((command (el-get-lock-update-check-build-git-command recipe url))
         (result (shell-command-to-string command)))
    (if (>= (string-width result) 40)
        (substring result 0 40)
      nil)))

(defun el-get-lock-update-check-process-hash (recipe url checksum)
  (let ((hash (el-get-lock-update-check-get-git-hash-string recipe url)))
    (cond ((or (null hash) (not (string-match-p "^[0-9a-z]\\{40\\}$" hash)))
           '(cannot-get-hash-packages . (concat "cannot get hash. got hash string is " hash)))
          ((string-equal checksum hash)
           '(nil . "no updates."))
          (t
           `(obsolute-packages . ,(concat "update found! " checksum "..." hash))))))

(defun el-get-lock-update-check-process-maybe-emacswiki (type)
  (if (eq type 'emacswiki)
      '(emacswiki-packages . "cannot get url because install from emacswiki")
    '(cannot-get-url-packages . "cannot get url.")))

(defun el-get-lock-update-check-process-installed-package (package)
  (let* ((recipe (ignore-errors (el-get-package-def package)))
         (type (plist-get recipe :type))
         (pkgname (plist-get recipe :pkgname))
         (url (if (eq type 'github)
                  (concat "https://github.com/" pkgname ".git")
                (plist-get recipe :url))))
    (if url
        (el-get-lock-update-check-process-hash recipe url checksum)
      (el-get-lock-update-check-process-maybe-emacswiki))))

(defun el-get-lock-update-check-process-single-package (package check-installed)
  (if (or (not check-installed) (el-get-package-installed-p package))
      (el-get-lock-update-check-process-installed-package package)
    '(not-installed-packages . "not installed.")))

(defun el-get-lock-update-check-assemble-lists (check-installed)
  (load (concat user-emacs-directory "init-el-get.el"))
  (message "check updates...")
  (let ((obsolute-packages '())
        (cannot-get-url-packages '())
        (emacswiki-packages '())
        (cannot-get-hash-packages '())
        (not-installed-packages '())
        (el-get-default-process-sync t)
        (versions (cdr el-get-lock-package-versions)))
    (dolist (version versions)
      (let (list-name
            message
            (package (replace-regexp-in-string "\\\\\\\." "\\\." (symbol-name (car version))))
            (checksum (plist-get (cdr version) :checksum)))
        (el-get-lock-update-check-verbose-print (concat package " checking..."))
        (let ((list-name-and-message (el-get-lock-update-check-process-single-package package check-installed)))
          (setq list-name (car list-name-and-message))
          (setq message (cdr list-name-and-message)))
        (if list-name (add-to-list list-name package))
        (if message (el-get-lock-update-check-verbose-print message)))
      (el-get-lock-update-check-verbose-print "\n"))
    `((obsolute . ,obsolute-packages)
      (cannot-get-url . ,cannot-get-url-packages)
      (emacswiki . ,emacswiki-packages)
      (cannot-get-hash . ,cannot-get-hash-packages)
      (not-installed . ,not-installed-packages)))
  )

(defun el-get-lock-update-check-execute (&optional only-obsolute-count)
  (let ((lists (el-get-lock-update-check-assemble-lists t)))
    (if only-obsolute-count
        (princ (concat (number-to-string (length (alist-get 'obsolute lists))) "\n"))
      (el-get-lock-update-check-print-list "obsolute" (alist-get 'obsolute lists))
      (el-get-lock-update-check-print-list "not installed" (alist-get 'not-installed lists))
      (el-get-lock-update-check-print-list "cannot get hash" (alist-get 'cannot-get-hash lists))
      (el-get-lock-update-check-print-list "emacswiki" (alist-get 'emacswiki lists))
      (el-get-lock-update-check-print-list "cannot-get-url" (alist-get 'cannot-get-url lists)))
    ))

;; HACK
;; Define macros similar to those loaded in the real environment
;; to avoid indentation deviations between Ci and real environments
(defmacro with-simulated-input (keys & rest body))
(defmacro with-editor (&rest body))
