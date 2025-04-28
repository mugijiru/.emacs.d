(el-get-bundle hydra)

(el-get-bundle hydra-posframe)

(add-hook 'after-init-hook 'hydra-posframe-enable)

(el-get-bundle major-mode-hydra.el)

(custom-set-variables '(pretty-hydra-default-title-body-format-spec "%s\n%s"))

(pretty-hydra-define el-get-hydra (:separator "-" :title "el-get" :foreign-key warn :quit-key "q" :exit t)
  ("Install"
   (("i" el-get-install   "Install")
    ("I" el-get-reinstall "Re-install")
    ("D" el-get-remove    "Uninstall"))

   "Update"
   (("s" el-get-self-update  "Self Update")
    ("u" el-get-update       "Update")
    ("A" el-get-update-all   "Update All")
    ("r" el-get-reload       "Reload"))

   "Recipe"
   (("f" el-get-find-recipe-file              "Find recipe")
    ("E" el-get-elpa-build-local-recipes      "Build ELPA recipes")
    ("W" el-get-emacswiki-build-local-recipes "Build EmacsWiki recipes"))

   "Lock"
   (("C" el-get-lock-checkout  "Checkout")
    ("U" el-get-lock-unlock    "Unlock"))))

(pretty-hydra-define
  toggle-hydra
  (:separator "-"
              :title (concat (all-the-icons-faicon "toggle-on") " Toggle Switches")
              :foreign-key warn
              :quit-key "q"
              :exit t)
  ("View"
   (("z" zoom-mode                 "zoom-mode"      :toggle zoom-mode)
    ("Z" toggle-frame-fullscreen   "Fullscreen"     :toggle (frame-parameter nil 'fullscreen))
    ("e" emojify-mode              "Emojify"        :toggle emojify-mode)
    ("B" blamer-mode               "Blamer"         :toggle blamer-mode)
    ("L" display-line-numbers-mode "Line Number"    :toggle display-line-numbers-mode)
    ("M" minimap-mode              "Minimap"        :toggle minimap-mode)
    ("T" treemacs                  "Treemacs"       :toggle (and (fboundp 'treemacs-current-visibility)
                                                                 (eq (treemacs-current-visibility) 'visible)))
    ("N" neotree-toggle            "Neotree"        :toggle (if (fboundp 'neo-global--window-exists-p) (neo-global--window-exists-p) nil)))

   "Mode Line"
   (("w" which-function-mode       "Which func"     :toggle which-func-mode)
    ("b" display-battery-mode      "Battery"        :toggle display-battery-mode))

   "Behavior"
   (("S" my/notify-slack-toggle    "Notify Slack"   :toggle my/notify-slack-enable-p)
    ("v" my/toggle-view-mode       "Readonly"       :toggle view-mode)
    ("f" flycheck-mode             "Flycheck"       :toggle flycheck-mode)
    ("A" auto-fix-mode             "Auto fix"       :toggle auto-fix-mode)
    ("C" copilot-mode              "Copilot"        :toggle copilot-mode)
    ("^" subword-mode              "Subword"        :toggle subword-mode)
    ("(" smartparens-strict-mode   "strict parens"  :toggle smartparens-strict-mode)
    ("E" toggle-debug-on-error     "Debug on error" :toggle debug-on-error))))

(pretty-hydra-define
  subtools-hydra
  (:separator "-"
              :color teal
              :foreign-key warn
              :title (concat (all-the-icons-material "build") " Sub tools")
              :quit-key "q"
              :exit t)
  ("Describe"
   (("b" counsel-descbinds "Keybind")
    ("f" counsel-describe-function "Function")
    ("v" counsel-describe-variable "Variable")
    ("m" describe-minor-mode "Minor mode"))
   "Other"
   (("@" all-the-icons-hydra/body "List icons")
    ("w" which-key-show-top-level "Which key")
    ("P" my/copy-file-path        "Get path")
    ("d" docker                   "Docker"))))

(pretty-hydra-define text-scale-hydra (:separator "-" :title (concat (all-the-icons-material "text_fields") " Text Scale") :exit nil :quit-key "q")
  ("Scale"
   (("+" text-scale-increase "Increase")
    ("-" text-scale-decrease "Decrease")
    ("0" text-scale-adjust   "Adjust"))))

(pretty-hydra-define pretty-hydra-usefull-commands (:separator "-" :color teal :foreign-key warn :title (concat (all-the-icons-material "build") " Usefull commands") :quit-key "q")
  ("File"
   (("p" projectile-hydra/body "Projectile")
    ("f" counsel-find-file     "Find File")
    ("d" counsel-find-dir      "Find Dir")
    ("r" counsel-recentf       "Recentf")
    ("L" counsel-locate        "Locate"))

   "Edit"
   (("a" align-regexp "Align Regexp")
    ("[" origami-hydra/body "Origami")
    (";" comment-dwim "Comment"))

   "Code"
   (("G" counsel-projectile-rg            "Grep")
    ("j" dumb-jump-pretty-hydra/body      "Dumb jump")
    ("g" avy-hydra/body                   "Avy")
    ("l" pretty-hydra-lsp/body            "LSP")
    ("i" counsel-imenu                    "imenu")
    ("y" yasnippet-hydra/body             "Yasnippet")
    ("B" browse-at-remote                 "Browse")
    ("C" blamer-show-posframe-commit-info "Bramer")
    ("m" magit-status                     "Magit"))

   "View"
   (("D" delete-other-windows      "Only This Win")
    ("W" window-control-hydra/body "Window Control")
    ("+" text-scale-hydra/body     "Text Scale")
    ("w" ace-swap-window           "Swap Window"))

   "Tool"
   (("SPC" major-mode-hydra         "Hydra(Major)")
    ("h"   my/project-hydra         "Hydra(Project)")
    ("s"   toggle-hydra/body        "Toggle switches")
    ("c"   counsel-org-capture      "Capture")
    ("A"   copilot-chat-hydra/body  "Copilot Chat")
    ("o"   global-org-hydra/body    "Org")
    ("e"   el-get-hydra/body        "el-get")
    ("k"   kibela-hydra/body        "Kibela")
    ("/"   google-pretty-hydra/body "Google")
    ("t"   subtools-hydra/body      "Sub Tools"))))

(let ((common-heads '("Operation"
                      (("x" kill-region                       "Cut")
                       ("w" kill-ring-save                    "Copy")
                       ("/" google-this-region                "Google")
                       ("t" google-translate-at-point         "EN => JP")
                       ("T" google-translate-at-point-reverse "JP => EN"))
                      "Other"
                      ((";" pretty-hydra-usefull-commands/body "Usefull commands")
                       ("M" major-mode-hydra "Major mode")
                       ("P" projectile-hydra/body "Projectile")))))
  (eval
   `(pretty-hydra-define selecting-hydra (:separator "-" :title "Selecting" :quit-key "q" :exit t)
      (,@common-heads)))
  (eval `(pretty-hydra-define org-selecting-hydra (:separator "-" :title "Selecting" :quit-key "q" :exit t)
           (,@(append '("Decoration"
                        (("*" (org-emphasize ?*)  "Bold")
                         ("/" (org-emphasize ?/)  "Italic")
                         ("~" (org-emphasize ?~)  "Code")
                         ("_" (org-emphasize ?_)  "Underline")
                         ("=" (org-emphasize ?=)  "Highlight")
                         ("+" (org-emphasize ?+)  "Strike-through")
                         ("z" (org-emphasize ?\s) "Remove")))
                      common-heads)))))

(defun my/dynamic-selecting-hydra ()
  (interactive)
  (cl-case major-mode
    ('org-mode (org-selecting-hydra/body))
    ('org-journal-mode (org-selecting-hydra/body))
    (t (selecting-hydra/body))))

(defun my/context-hydra ()
  (interactive)
  (if (use-region-p)
      (my/dynamic-selecting-hydra)
    (pretty-hydra-usefull-commands/body)))
