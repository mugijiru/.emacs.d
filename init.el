(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
;; (package-initialize)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")

(el-get-bundle init-loader)
(init-loader-load)

;; helm 系の設定は他の部分への影響も大きそうなので先に持って来た
(el-get-bundle helm)
(el-get-bundle helm-descbinds)
(require 'helm-config)
(helm-descbinds-mode)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-;") 'helm-for-files)
(global-set-key (kbd "M-x") 'helm-M-x)


;; for Ruby
(el-get-bundle rbenv)
(global-rbenv-mode)
(el-get-bundle enh-ruby-mode)

;; for Rails
(el-get-bundle projectile-rails)

;; for JS
(el-get-bundle js2-mode)
(defun my/js2-mode-hook ()
  (flycheck-mode)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))
  (setq js2-basic-offset 2))
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
(add-hook 'js2-mode-hook 'my/js2-mode-hook)

(el-get-bundle ember-mode)
(el-get-bundle vue-mode)

;; for Emacs Lisp
(el-get-bundle paredit)

;; for other development
(el-get-bundle haml-mode)
(el-get-bundle handlebars-mode)
(el-get-bundle pug-mode)
(el-get-bundle yaml-mode)
(el-get-bundle markdown-mode)

;; プログラミング一般
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         spaces         ; スペース
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 行末の空白も表示
(setq whitespace-trailing-regexp  "\\([ \u00A0]+\\)$")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)


(el-get-bundle flycheck)
(show-paren-mode 1) ;; http://syohex.hatenablog.com/entry/20110331/1301584188
(el-get-bundle projectile)
(el-get-bundle helm-projectile)
(el-get-bundle git-gutter-fringe)
(global-git-gutter-mode t)
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


;; for japanese
(el-get-bundle ddskk)
(add-hook 'skk-load-hook
          (lambda ()
            ;; コード中では自動的に英字にする。
            (require 'context-skk)

            ;; 半角で入力したい文字
            (setq skk-rom-kana-rule-list
                  (nconc skk-rom-kana-rule-list
                         '((";" nil nil)
                           (":" nil nil)
                           ("?" nil nil)
                           ("!" nil nil))))))
(setq skk-sticky-key ";")

(el-get-bundle migemo)
(load "migemo")
(setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
(setq migemo-command "/usr/local/bin/cmigemo")
(setq migemo-options '("-q" "--emacs"))
(setq migemo-coding-system 'utf-8-unix)
(migemo-init)

;; keybinds

(if (eq window-system 'ns)
    (progn
          (setq ns-alternate-modifier (quote super)) ;; option  => super
          (setq ns-command-modifier (quote meta))))  ;; command => meta

;; C-h を backspace に
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)

;; M-g rをstring-replaceに割り当て
(global-set-key (kbd "M-g r") 'replace-string)

;; Shift+矢印でwindow移動
(windmove-default-keybindings)

;; ¥ ではなく \ になるように調整
(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])

; multiple-cursors
(global-set-key (kbd "C-:") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; sticky control
(el-get-bundle sticky-control)
(sticky-control-set-key 'sticky-control-key 44)
(setq sticky-control-shortcuts
      '((?c . "\C-c")
        (?g . "\C-g")
        (?k . "\C-k")
        (?a . "\C-a")
        (?e . "\C-e")
        (?n . "\C-n")
        (?o . "\C-o")
        (?p . "\C-p")
        (?j . "\C-j")
        (?f . "\C-f")
        (?b . "\C-b")
        (?x . "\C-x")
        (?r . "\C-r")
        (?s . "\C-s")))

(sticky-control-mode)

;; fullscreen
(if (eq window-system 'ns)
    (add-hook 'window-setup-hook
                (lambda ()
                  (set-frame-parameter nil 'fullscreen 'fullboth))))

(el-get-bundle molokai-theme)
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/el-get/molokai-theme"))
(load-theme 'molokai t)

(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file)
