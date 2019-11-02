;; posframe が最初に空行があると最後お行を表示しないため
;; 一時的にこちらを直してみている
(with-eval-after-load 'pretty-hydra
  (defun pretty-hydra--maybe-add-title (title docstring)
  "Add TITLE to the DOCSTRING if it's not nil, other return DOCSTRING unchanged."
  (if (null title)
      docstring
    (format "%s\n%s"
            (cond
             ((char-or-string-p title) title)
             ((symbolp title)          (format "%%s`%s" title))
             ((listp title)            (format "%%s%s" (prin1-to-string title)))
             (t                        ""))
            docstring))))
