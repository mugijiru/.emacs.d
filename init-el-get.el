(add-to-list 'load-path (concat user-emacs-directory "el-get/el-get"))

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path (concat user-emacs-directory "recipes") )

;; el-get のバージョンロック機構の導入
(el-get-bundle tarao/el-get-lock)
(let ((el-get-default-process-sync t))
  (el-get-lock))


;; 自動アップデートの対象リスト
(setq my/el-get-auto-update-targets
      '(
        "smartparens"
        ;; "mocker\.el"
        ;; "with-simulated-input"
        ;; "flycheck-pos-tip"
        ;; ;; ;; "pos-tip"
        ;; "emacs-neotree"
        ;; "company-lsp"
        ;; "emacs-w3m"
        ;; "browse-at-remote"
        ;; "ox-hugo"
        ;; "sticky-control"
        ;; "org-pomodoro"
        ;; "org-ql"
        ;; "org-super-agenda"
        ;; "ts"
        ;; "ov"
        ;; "diminish"
        ;; "open-junk-file"
;;         "htmlize"
;;         "ivy-rich"
;;         "emacs-neotree-dev"
;;         "color-theme-molokai"
;;         "helm-posframe"
;;         "gnuplot-mode"
;;         "ivy-posframe"
;;         "dumb-jump"
;;         "ember-mode"
;;         "font-lock+"
;;         "emacs-hide-mode-line"
;;         "highlight-indent-guides"
;;         "org-export-blocks-format-plantuml"
;;         "ruby-end"
;;         "scratch-log"
;;         "tempbuf"
;;         "vue-mode"
;;         "mmm-mode"
;;         "ssass-mode"
;;         "edit-indirect"
;;         "vue-html-mode"
;;         "emacs-pug-mode"
;;         "zoom"
;;         "request"
;;         "helm"
;;         "avy"
;;         ;; "all-the-icons"
;;         "alert"
;;         "calfw"
;;         "closql"
;;         "company-mode"
;;         "counsel-projectile"
;;         "dash"
;;         "ddskk"
;;         "ddskk-posframe\.el"
;;         "deferred"
;;         "doom-modeline"
;;         "el-get-lock"
;;         "eldoc-eval"
;;         "emacs-async"
;;         "emacsql"
;;         ;; "emojify"
;;         "enh-ruby-mode"
;;         "epl"
;;         "esa"
;;         "esqlite"
;;         "exec-path-from-shell"
;;         "f"
;;         ;; "flycheck"
;;         ;; "forge"
;;         ;; "fringe-helper"
;;         ;; "ghub"
;;         ;; "git-gutter"
;;         ;; "git-gutter-fringe"
;;         ;; "google-this"
;;         ;; "graphql"
;;         ;; "haml-mode"
;;         ;; "handlebars-mode"
;;         ;; "helm-ag"
;;         ;; "helm-descbinds"
;;         ;; "helm-projectile"
;;         ;; "hexmode--xml-rpc"
;;         ;; "ht"
;;         ;; "hydra"
;;         ;; "hydra-posframe"
;;         ;; "inf-ruby"
;;         ;; "init-loader"
;;         ;; "japanese-holidays"
;;         ;; "js2-mode"
;;         ;; "jump"
;;         ;; "key-chord"
;;         ;; "lsp-mode"
;;         ;; "lsp-ui"
;;         ;; "major-mode-hydra\.el"
;;         ;; "magit"
;;         ;; "markdown-mode"
;;         ;; "memoize"
;;         ;; "migemo"
;;         ;; "multiple-cursors"
;;         ;; "ob-async"
;;         ;; "org-gcal"
;;         ;; "org-tree-slide"
;;         ;; "paredit"
;;         ;; "pkg-info"
;;         ;; "plantuml-mode"
;;         ;; "popup"
;;         ;; "posframe"
;;         ;; "prescient\.el"
;;         ;; "projectile"
;;         ;; "projectile-rails"
;;         ;; "rake"
;;         ;; "rbenv"
;;         ;; "rich-minority"
;;         ;; "rspec-mode"
;;         ;; "s"
;;         ;; "seesaa-blog-mode"
;;         ;; "shrink-path"
;;         ;; "smart-mode-line"
;;         ;; "spinner"
;;         ;; "swiper"
;;         ;; "transient"
;;         ;; "treepy"
;;         ;; "twittering-mode"
;;         ;; ;; "wakatime-mode"
;;         ;; "websocket"
;;         ;; "with-editor"
;;         ;; "yaml-mode"
;;         ;; "yascroll"
;;         ;; "yasnippet"
;;         ;; "zoom-window"
;;         ;; "ace-window"
;;         ;; ;; "pcsv"
;;         ;; "google-translate"
;;         ;; "counsel-osx-app"
;;         ;; "frame-cmds"
;;         ;; "frame-fns"
;;         ;; "el-get"
;;         ;; "dashboard"
;;         ;; "page-break-lines"
;;         ;; "org-trello"
;;         ;; "undo-fu"
;;         ;; "emacs-todoist"
;;         ;; "org-mode"
        ))

;; (mapcar (lambda (package-with-version)
;;                 (car package-with-version))
;;               el-get-lock-package-versions)

(defun my/el-get-auto-update ()
  (let* ((el-get-default-process-sync t))
    (el-get-lock-checkout "el-get")
    (sit-for 10) ;; el-get がなんか読み込まれてるので待ってみる
    (loop for package in my/el-get-auto-update-targets
          do
          (message (concat "update package " package))
          (el-get-lock-checkout package)
          (el-get-update package)
          )))
