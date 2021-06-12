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
(el-get-lock)

;; 自動アップデートの対象リスト
(setq my/el-get-auto-update-targets
      '("smartparens"
        "with-simulated-input"
        "flycheck-pos-tip"))

(defun my/el-get-auto-update ()
  (load (concat user-emacs-directory "inits/99-with-simulated-input.el"))

  (setq el-get-default-process-sync t)
  (loop for package in my/el-get-auto-update-targets
        do (el-get-update package)))
