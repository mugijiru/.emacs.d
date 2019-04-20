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

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; for JS
(el-get-bundle js2-mode)
(el-get-bundle ember-mode)
(el-get-bundle vue-mode)

;; for other development
(el-get-bundle haml-mode)
(el-get-bundle handlebars-mode)
(el-get-bundle pug-mode)
(el-get-bundle yaml-mode)
(el-get-bundle markdown-mode)

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


(setq custom-file (expand-file-name "~/.emacs.d/custom.el"))
(load custom-file)
