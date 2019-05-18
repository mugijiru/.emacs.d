(el-get-bundle org-mode) ;; from Git. because melpa cannot resolve dependencies.
(el-get-bundle org-export-blocks-format-plantuml)
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(setq org-directory (expand-file-name "~/Documents/org/"))

;; フッターなくしたり
(setq org-export-html-footnotes-section "")
(setq org-export-html-footnote-format "")
(setq org-export-with-footnotes nil)
(setq org-export-with-creator nil)
(setq org-export-with-author nil)
(setq org-html-validation-link nil)

;; for seesaa blog settings
(setq org-export-author-info nil)
(setq org-export-email-info nil)
(setq org-export-creator-info nil)
(setq org-export-time-stamp-file nil)
(setq org-export-with-timestamps nil)
(setq org-export-with-section-numbers nil)
(setq org-export-with-sub-superscripts nil)

;;; Table of Contents を出さない
(setq org-export-with-toc nil)

;;; h1でサイト名出さない
(setq org-export-html-preamble nil)
(setq org-html-preamble nil)

;;; *bold* とか /italic/ とか _underline_ とかを<b>とかにしないようにする
(setq org-export-with-emphasize nil)

;; デフォは日本語設定
(setq org-export-default-language "ja")

;; org-agenda
;; (setq org-agenda-files
;;       '("~/Documents/org/org-ical.org"
;;         "~/Documents/org/next.org"
;;         "~/Documents/org/work.org"
;;         "~/Documents/org/google-calendar.org"
;;         "~/Documents/org/research.org"))
(setq org-agenda-files
      '("~/Documents/org/org-ical.org"
        "~/Documents/org/google-calendar.org"
))

;; org-capture
(defvar org-capture-ical-file (concat org-directory "org-ical.org"))
(setq org-capture-ical-file (concat org-directory "org-ical.org"))

(setq org-capture-templates
      `(("c" "同期カレンダーにエントリー" entry
         (file+headline ,org-capture-ical-file "Schedule")
         "** TODO %?\n\t")))
