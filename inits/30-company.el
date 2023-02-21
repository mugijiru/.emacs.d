(el-get-bundle company-mode)

(with-eval-after-load 'company
  ;; active
  (define-key company-active-map (kbd "C-s") 'company-search-candidates))

(custom-set-variables '(company-show-quick-access t))

(el-get-bundle company-quickhelp)
