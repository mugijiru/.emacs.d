;; ;; https://gist.github.com/garaemon/8851900ef27d8cb28200ac8d92ebacdf
;; ;; Increase threshold to fire garbage collection
;; (setq gc-cons-threshold 1073741824)
;; (setq garbage-collection-messages t)


;; ;; Run GC every 60 seconds if emacs is idle.
;; (run-with-idle-timer 60.0 t #'garbage-collect)

(el-get-bundle gcmh)
