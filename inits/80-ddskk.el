(el-get-bundle ddskk)
(add-hook 'skk-load-hook
          (lambda ()
            ;; コード中では自動的に英字にする。
            (require 'context-skk)

            ;; 半角で入力したい文字
            (setq skk-rom-kana-rule-list
                  (nconc skk-rom-kana-rule-list
                         '((";" nil nil)
                           (":" nil nil)
                           ("?" nil nil)
                           ("!" nil nil))))))
(setq skk-sticky-key ";")
