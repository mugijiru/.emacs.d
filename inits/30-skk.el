(el-get-bundle ddskk)

(defun my/always-enable-skk-latin-mode-hook ()
  (skk-latin-mode 1))

(add-hook 'find-file-hooks 'my/always-enable-skk-latin-mode-hook)

(add-hook 'skk-load-hook
          (lambda ()
            ;; コード中では自動的に英字にする。
            (require 'context-skk)

            (setq skk-comp-mode t) ;; 動的自動補完
            (setq skk-auto-insert-paren t)
            (setq skk-delete-implies-kakutei nil)
            (setq skk-sticky-key ";")
            (setq skk-henkan-strict-okuri-precedence t)
            (setq skk-show-annotation t) ;; 単語の意味をアノテーションとして表示。例) いぜん /以前;previous/依然;still/

            ;; ;; 半角で入力したい文字
            ;; (setq skk-rom-kana-rule-list
            ;;       (nconc skk-rom-kana-rule-list
            ;;              '((";" nil nil)
            ;;                (":" nil nil)
            ;;                ("?" nil nil)
            ;;                ("!" nil nil))))
            ))

(setq skk-extra-jisyo-file-list (list '("~/.emacs.d/skk-jisyo/SKK-JISYO.lisp" . japanese-iso-8bit-unix)))

(let ((l-dict
       (if (eq window-system 'ns)
           (expand-file-name "~/Library/Application Support/AquaSKK/SKK-JISYO.L")
         "/usr/share/skk/SKK-JISYO.L")))
  (if (file-exists-p l-dict)
      (setq skk-large-jisyo l-dict)))

(el-get-bundle conao3/ddskk-posframe.el)
(ddskk-posframe-mode 1)
