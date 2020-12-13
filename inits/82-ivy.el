(el-get-bundle abo-abo/swiper) ;; ivy, swiper, counsel が同時に入って来る

(when (require 'ivy nil t)
  ;; M-o を ivy-dispatching-done-hydra に割り当てる．
  (require 'ivy-hydra)

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; (index/総数) 表示で何番目の候補かわかりやすくする
  (setq ivy-count-format "(%d/%d) ")

  ;; アクティベート
  (ivy-mode 1))

(counsel-mode 1)

;; posframe を使って中央表示
(el-get-bundle ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
(ivy-posframe-mode 1)

(el-get-bundle ivy-rich)

;; https://ladicle.com/post/config/#ivy
;; に書かれている関数を丸コピしてきた
(defun ivy-rich-file-icon (candidate)
  "Display file icons in `ivy-rich'."
  (when (display-graphic-p)
    (let ((icon (if (file-directory-p candidate)
                    (cond
                     ((and (fboundp 'tramp-tramp-file-p)
                           (tramp-tramp-file-p default-directory))
                      (all-the-icons-octicon "file-directory"))
                     ((file-symlink-p candidate)
                      (all-the-icons-octicon "file-symlink-directory"))
                     ((all-the-icons-dir-is-submodule candidate)
                      (all-the-icons-octicon "file-submodule"))
                     ((file-exists-p (format "%s/.git" candidate))
                      (all-the-icons-octicon "repo"))
                     (t (let ((matcher (all-the-icons-match-to-alist candidate all-the-icons-dir-icon-alist)))
                          (apply (car matcher) (list (cadr matcher))))))
                  (all-the-icons-icon-for-file candidate))))
      (unless (symbolp icon)
        (propertize icon
                    'face `(
                            :height 1.1
                            :family ,(all-the-icons-icon-family icon)
                            ))))))

;; https://github.com/Yevgnen/ivy-rich#1312-add-icons-for-ivy-switch-buffer
(defun ivy-rich-switch-buffer-icon (candidate)
  (with-current-buffer
      (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode)))
      (if (symbolp icon)
          (all-the-icons-icon-for-mode 'fundamental-mode)
        icon))))

;; yank-pop の区切りを変更。ちょっと長めにしている
(setq counsel-yank-pop-separator "\n--------------------\n")

(setq ivy-rich-display-transformers-list
      '(ivy-switch-buffer
        (:columns
         ((ivy-rich-switch-buffer-icon :width 2)
          (ivy-rich-candidate (:width 30))
          (ivy-rich-switch-buffer-size (:width 7))
          (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
          (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
          (ivy-rich-switch-buffer-project (:width 15 :face success))
          (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
         :predicate
         (lambda (cand) (get-buffer cand)))
        counsel-M-x
        (:columns
         ((counsel-M-x-transformer (:width 40))  ; thr original transformer
          (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))  ; return the docstring of the command
        counsel-find-file
        (:columns
         ((ivy-rich-file-icon)
          (ivy-rich-candidate)))
        counsel-recentf
        (:columns
         ((ivy-rich-file-icon)
          (ivy-rich-candidate (:width 110))))
        ))

(ivy-rich-mode 1)

;; https://www.yewton.net/2020/05/21/migemo-ivy/
;; 関数名などは書き換えてる
(defun my/ivy-migemo-re-builder (str)
  (let* ((sep " \\|\\^\\|\\.\\|\\*")
         (splitted (--map (s-join "" it)
                          (--partition-by (s-matches-p " \\|\\^\\|\\.\\|\\*" it)
                                          (s-split "" str t)))))
    (s-join "" (--map (cond ((s-equals? it " ") ".*?")
                            ((s-matches? sep it) it)
                            (t (migemo-get-pattern it)))
                      splitted))))

(setq ivy-re-builders-alist '((t . ivy--regex-plus)
                              (swiper . my/ivy-migemo-re-builder)))
