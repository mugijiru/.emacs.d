(el-get-bundle emacs-w3m)

(defun w3m-filter-rurema (url)
  (goto-char (point-min))
  (let ((deletions '(("<div class=\"description\">" . "</div>")
                     ("<div class=\"version-select\">" . "</div>")
                     ("<div class=\"topic-path\">" . "</div>")
                     ("<div class=\"drilldown list-box\">" . "</div>"))))
    (dolist (deletion deletions)
      (let ((begin-regex (car deletion))
            (end-regex (cdr deletion)))
        (w3m-filter-delete-regions url begin-regex end-regex)))))

(add-to-list 'w3m-filter-configuration
             '(t
               ("Strip Rurema menus" "Rurema のメニュー等を取り除きます")
               "\\`https://rurema\\.clear-code\\.com/"
               w3m-filter-rurema))
