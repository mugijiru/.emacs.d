(el-get-bundle migemo)
(load "migemo")

;; Mac
(let ((path "/usr/local/share/migemo/utf-8/migemo-dict"))
  (if (file-exists-p path)
      (setq migemo-dictionary path)))

;; Ubuntu
(let ((path "/usr/share/cmigemo/utf-8/migemo-dict"))
  (if (file-exists-p path)
      (setq migemo-dictionary path)))

;; Manjaro
(let ((path "/usr/share/migemo/utf-8/migemo-dict"))
  (if (file-exists-p path)
      (setq migemo-dictionary path)))

(let ((path (s-chomp (shell-command-to-string "which cmigemo"))))
  (if (s-ends-with? "not found" path)
      (message "cmigemo not found")
    (setq migemo-command path)))

(setq migemo-options '("-q" "--emacs"))

(setq migemo-coding-system 'utf-8-unix)

(migemo-init)
