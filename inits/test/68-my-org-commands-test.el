(require 'ert)

;; プラグイン読み込みの前準備
(load (expand-file-name (concat user-emacs-directory "/init-el-get.el")))

;; 入力シミュレート用のプラグイン
(load (expand-file-name (concat user-emacs-directory "/inits/99-with-simulated-input")))

(el-get-bundle abo-abo/swiper)

;; テスト対象の読み込み
(load (expand-file-name (concat user-emacs-directory "/inits/68-my-org-commands.el")))

(ert-deftest test:my/org-todo-keyword-strings ()
  "Test of `my/org-todo-keyword-strings'."
  (let ((org-todo-keywords '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)"))))
    (should (equal '("TODO" "DOING" "WAIT" "DONE" "SOMEDAY")
                   (my/org-todo-keyword-strings)))))

(ert-deftest test:my/org-todo ()
  "Test of `my/org-todo'."
  (let ((org-todo-keywords '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
        (result))
    ;; org-mode を読まずに済むように org-todo を差し替えてテストしている
    (cl-letf (((symbol-function 'org-todo)
               (lambda (keyword)
                 (setq result keyword))))
      (with-simulated-input "DOI RET" (my/org-todo))
      (should (equal "DOING" result)))))
