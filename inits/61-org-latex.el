;; (require 'ox-latex)

;; (setq org-image-actual-width nil)

(setq org-latex-pdf-process '("latexmk -gg -pdfdvi %f"))
;; (setq org-beamer-outline-frame-title "目次")
;; (setq org-latex-default-class "bxjsarticle")
(setq org-latex-default-class "article")
;; (setq org-latex-default-class "article")
;; (setq org-export-with-author t)
