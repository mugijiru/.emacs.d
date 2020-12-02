(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-sources (quote ("~/.emacs.d/.authinfo.gpg")))
 '(auto-insert-directory "~/.emacs.d/insert/")
 '(aw-background t)
 '(column-number-mode t)
 '(counsel-locate-cmd (quote counsel-locate-cmd-mdfind))
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" default)))
 '(el-get-notify-type (quote message))
 '(global-yascroll-bar-mode t)
 '(google-this-browse-url-function (quote w3m-browse-url))
 '(google-this-keybind "")
 '(google-this-location-suffix "co.jp")
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(google-translate-output-destination nil)
 '(helm-for-files-preferred-list
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-bookmarks helm-source-projectile-files-list helm-source-file-cache helm-source-files-in-current-dir helm-source-locate)))
 '(helm-locate-command "mdfind %s %s")
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(line-number-mode nil)
 '(major-mode-hydra-separator "=")
 '(org-confirm-babel-evaluate nil)
 '(org-html-doctype "html5")
 '(org-modules
   (quote
    (ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus ol-info ol-irc ol-mhe ol-rmail org-tempo ol-w3m)))
 '(org-plantuml-jar-path
   (expand-file-name "~/.emacs.d/el-get/plantuml-mode/plantuml.jar"))
 '(package-selected-packages
   (quote
    (peg persist gnu-elpa-keyring-update oauth2 highlight-indent-guides rainbow-mode xml-rpc)))
 '(projectile-mode-line-prefix "")
 '(pug-tab-width 2)
 '(recentf-auto-cleanup (quote never))
 '(recentf-max-saved-items 500)
 '(rspec-use-opts-file-when-available nil)
 '(safe-local-variable-values (quote ((flycheck-stylelintrc . ".stylelintrc.yml"))))
 '(scroll-bar-mode nil)
 '(yascroll:delay-to-hide nil)
 '(zoom-mode t nil (zoom))
 '(zoom-size (quote (0.618 . 0.618))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "red" :height 4.0)))))
