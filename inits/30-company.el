(el-get-bundle company-mode)

(with-eval-after-load 'company
  ;; active
  (define-key company-active-map (kbd "C-s") 'company-search-candidates))

(setopt company-show-quick-access t)

(el-get-bundle company-quickhelp)

(setopt company-quickhelp-color-background "#323445")

(with-eval-after-load 'pos-tip
  (company-quickhelp-mode 1))

(el-get-bundle company-posframe)
(company-posframe-mode 1)
