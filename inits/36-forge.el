;; magit と github を連携させるやつ
(el-get-bundle forge)

(with-eval-after-load 'magit
  (require 'forge))
