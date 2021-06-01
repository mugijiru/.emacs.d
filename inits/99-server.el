;; サーバとして起動
;; Firefox から org-capture を動かすのに必要
(require 'server)
(unless (server-running-p)
  (server-start))
