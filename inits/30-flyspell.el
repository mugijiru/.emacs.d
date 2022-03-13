;; for hunspell
(with-eval-after-load "ispell"
  (setenv "DICTIONARY" "en_US")
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))
