(setq package-archives '(("org"   . "https://orgmode.org/elpa/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'leaf)
  (package-refresh-contents)
  (package-install 'leaf))

(leaf leaf-keywords
      :ensure t
      :init
      ;; optional packages if you want to use :hydra, :el-get, :blackout,,,
      ;; (leaf hydra :ensure t)
      (leaf el-get
        :ensure t
        :config (add-to-list 'el-get-recipe-path "~/.emacs.d/recipes"))
      (leaf blackout :ensure t)

      :config
      ;; initialize leaf-keywords.el
      (leaf-keywords-init))

(load "~/.emacs.d/init-el-get.el")

(el-get-bundle init-loader)
(init-loader-load)
