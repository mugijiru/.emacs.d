(el-get-bundle ivy-kibela)

(with-eval-after-load 'ivy
  (require 'ivy-kibela))

(custom-set-variables
 '(ivy-kibela-team (plist-get (nth 0 (auth-source-search :host "kibe.la")) :team))
 '(ivy-kibela-access-token (funcall (plist-get (nth 0 (auth-source-search :host "kibe.la" :max 1)) :secret))))

(with-eval-after-load 'ivy-kibela
  (add-to-list 'ivy-re-builders-alist '(ivy-kibela . ivy-migemo--regex-plus) t))
