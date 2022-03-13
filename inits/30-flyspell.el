;; for hunspell
(with-eval-after-load "ispell"
  (setenv "DICTIONARY" "en_US")
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")))

;; Original: https://takaxp.github.io/init.html#orgdd65fc08
(defun my/flyspell-ignore-nonascii (beg end _info)
  "incorrect判定をASCIIに限定"
  (string-match "[^!-~]" (buffer-substring beg end)))

(add-hook 'flyspell-incorrect-hook #'my/flyspell-ignore-nonascii)
