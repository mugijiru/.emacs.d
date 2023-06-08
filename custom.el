(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auth-sources '("~/.emacs.d/.authinfo.gpg"))
 '(auto-insert-directory "~/.emacs.d/insert/")
 '(aw-background t)
 '(column-number-mode t)
 '(company-show-quick-access t)
 '(counsel-projectile-switch-project-action
   '(1
     ("o" counsel-projectile-switch-project-action "jump to a project buffer or file")
     ("f" counsel-projectile-switch-project-action-find-file "jump to a project file")
     ("d" counsel-projectile-switch-project-action-find-dir "jump to a project directory")
     ("D" counsel-projectile-switch-project-action-dired "open project in dired")
     ("b" counsel-projectile-switch-project-action-switch-to-buffer "jump to a project buffer")
     ("m" counsel-projectile-switch-project-action-find-file-manually "find file manually from project root")
     ("S" counsel-projectile-switch-project-action-save-all-buffers "save all project buffers")
     ("k" counsel-projectile-switch-project-action-kill-buffers "kill all project buffers")
     ("K" counsel-projectile-switch-project-action-remove-known-project "remove project from known projects")
     ("c" counsel-projectile-switch-project-action-compile "run project compilation command")
     ("C" counsel-projectile-switch-project-action-configure "run project configure command")
     ("E" counsel-projectile-switch-project-action-edit-dir-locals "edit project dir-locals")
     ("v" counsel-projectile-switch-project-action-vc "open project in vc-dir / magit / monky")
     ("sg" counsel-projectile-switch-project-action-grep "search project with grep")
     ("si" counsel-projectile-switch-project-action-git-grep "search project with git grep")
     ("ss" counsel-projectile-switch-project-action-ag "search project with ag")
     ("sr" counsel-projectile-switch-project-action-rg "search project with rg")
     ("xs" counsel-projectile-switch-project-action-run-shell "invoke shell from project root")
     ("xe" counsel-projectile-switch-project-action-run-eshell "invoke eshell from project root")
     ("xt" counsel-projectile-switch-project-action-run-term "invoke term from project root")
     ("xv" counsel-projectile-switch-project-action-run-vterm "invoke vterm from project root")
     ("Oc" counsel-projectile-switch-project-action-org-capture "capture into project")
     ("Oa" counsel-projectile-switch-project-action-org-agenda "open project agenda")
     ("N" neotree-dir "Switch Neotree")))
 '(css-indent-offset 2)
 '(custom-safe-themes
   '("11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" default))
 '(el-get-notify-type 'message)
 '(global-yascroll-bar-mode t)
 '(google-this-browse-url-function 'w3m-browse-url)
 '(google-this-keybind "")
 '(google-this-location-suffix "co.jp")
 '(google-translate-default-source-language "en")
 '(google-translate-default-target-language "ja")
 '(google-translate-output-destination 'popup)
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(line-number-mode nil)
 '(major-mode-hydra-separator "=")
 '(org-agenda-files '("~/Documents/org/tasks/"))
 '(org-confirm-babel-evaluate nil)
 '(org-html-doctype "html5")
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail org-tempo ol-w3m))
 '(org-plantuml-jar-path
   (expand-file-name "~/.emacs.d/el-get/plantuml-mode/plantuml.jar"))
 '(package-selected-packages
   '(rainbow-mode persist peg gcmh gnu-elpa-keyring-update oauth2 xml-rpc))
 '(projectile-mode-line-prefix "")
 '(pug-tab-width 2)
 '(recentf-auto-cleanup 'never)
 '(recentf-max-saved-items 500)
 '(rspec-use-opts-file-when-available nil)
 '(safe-local-variable-values '((flycheck-stylelintrc . ".stylelintrc.yml")))
 '(scroll-bar-mode nil)
 '(wakatime-cli-path (expand-file-name "~/.anyenv/envs/pyenv/shims/wakatime"))
 '(wakatime-python-bin nil)
 '(yascroll:delay-to-hide nil)
 '(zoom-mode t nil (zoom))
 '(zoom-size '(0.618 . 0.618)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aw-leading-char-face ((t (:foreground "red" :height 4.0)))))
