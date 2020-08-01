(el-get-bundle ddskk)
(add-hook 'skk-load-hook
          (lambda ()
            ;; コード中では自動的に英字にする。
            (require 'context-skk)

            (setq skk-comp-mode t) ;; 動的自動補完
            (setq skk-auto-insert-paren t) ;; 閉じ括弧の自動補完
            (setq skk-delete-implies-kakutei nil) ;; ▼モードで BS を押した時に一つ前の候補を表示
            (setq skk-sticky-key ";") ;; sticky-shift key
            (setq skk-henkan-strict-okuri-precedence t) ;; 見出し語と送り仮名がマッチした候補を優先して表示
            (setq skk-show-annotation t) ;; 単語の意味をアノテーションとして表示。例) いぜん /以前;previous/依然;still/

            ;; 半角で入力したい文字
            (setq skk-rom-kana-rule-list
                  (nconc skk-rom-kana-rule-list
                         '((";" nil nil)
                           (":" nil nil)
                           ("?" nil nil)
                           ("!" nil nil))))))

(setq skk-extra-jisyo-file-list (list '("~/.emacs.d/skk-jisyo/SKK-JISYO.lisp" . japanese-iso-8bit-unix)))

;; AquaSKKのL辞書をつかうようにする
(let ((l-dict (expand-file-name "~/Library/Application Support/AquaSKK/SKK-JISYO.L")))
  (if (file-exists-p l-dict)
      (setq skk-large-jisyo l-dict)))

(el-get-bundle conao3/ddskk-posframe.el)
(ddskk-posframe-mode 1)
