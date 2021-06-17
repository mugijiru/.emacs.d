(el-get-bundle avy)
(setq avy-style 'pre)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define avy-hydra
    (:separator "-" :title "avy" :foreign-key warn :quit-key "q" :exit t)
    ("Char"
     (("c" avy-goto-char       "Char")
      ("C" avy-goto-char-2     "Char 2")
      ("x" avy-goto-char-timer "Char Timer"))

     "Word"
     (("w" avy-goto-word-1 "Word")
      ("W" avy-goto-word-0 "Word 0"))

     "Line"
     (("l" avy-goto-line "Line")))))
