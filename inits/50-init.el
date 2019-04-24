;; for other development
(el-get-bundle yaml-mode)
(el-get-bundle markdown-mode)

;; プログラミング一般

(el-get-bundle flycheck)
(show-paren-mode 1) ;; http://syohex.hatenablog.com/entry/20110331/1301584188
(el-get-bundle company-mode)
(el-get-bundle multiple-cursors)

;; for file actions
(require 'uniquify) ;; includes Emacs
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(ido-mode 1) ;; includes Emacs
(setq ido-enable-flex-matching t)

;; for other edit
(el-get-bundle org-mode) ;; from Git. because melpa cannot resolve dependencies.
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

(el-get-bundle seesaa-blog-mode) ;; for seesaa blog. dependent org-mdoe

(el-get-bundle emacs-w3m)
(el-get-bundle scratch-log)
