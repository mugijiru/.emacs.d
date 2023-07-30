(el-get-bundle company-mode)

(with-eval-after-load 'company
  ;; active
  (define-key company-active-map (kbd "C-s") 'company-search-candidates))

(custom-set-variables '(company-show-quick-access t))

(el-get-bundle company-quickhelp)
(company-quickhelp-mode t)

(custom-set-variables
 '(company-quickhelp-color-background "#323445"))

(el-get-bundle company-posframe)
(company-posframe-mode 1)
