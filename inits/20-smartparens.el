(el-get-bundle smartparens)

(require 'smartparens-config)

;; monkey patch for symbol definition void sp--syntax-class-to-char
;; See: https://github.com/Fuco1/smartparens/issues/1204#issuecomment-2052434191
(defalias 'sp--syntax-class-to-char #'syntax-class-to-char)
