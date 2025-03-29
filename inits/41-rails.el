(el-get-bundle rails-i18n)
(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)

(defun my/projectile-rails-find-service ()
  "Find a Service class file."
  (interactive)
  (projectile-rails-find-resource
   "Service: "
   '(("app/services/" "\\(.+\\.rb\\)$"))
   "app/services/${filename}"))

(defun my/projectile-rails-find-decorator ()
  "Find a Decorator file."
  (interactive)
  (projectile-rails-find-resource
   "Decorator: "
   '(("app/decorators/" "\\(.+\\.rb\\)$"))
   "app/decorators/${filename}"))

(defun my/projectile-rails-find-factory ()
  "Find a FactoryBot file."
  (interactive)
  (projectile-rails-find-resource
   "Factory: "
   '(("spec/factories/" "\\(.+\\)\\.rb$"))
   "spec/factories/${filename}.rb"))

(my/load-config "projectile-finders")

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-projectile-rails
    (:separator "-" :color blue :foreign-keys warn :title (concat (nerd-icons-devicon "nf-dev-ruby_on_rails") " Projectile Rails") :quit-key "q")
    ("Current"
     (("M" projectile-rails-find-current-model      "Current model")
      ("V" projectile-rails-find-current-view       "Current view")
      ("C" projectile-rails-find-current-controller "Current controller")
      ("H" projectile-rails-find-current-helper     "Current helper")
      ("P" projectile-rails-find-current-spec       "Current spec")
      ("J" projectile-rails-find-current-job        "Current Job")
      ;; TODO: implement my/projectile-rails-find-current-decorator
      ("Z" projectile-rails-find-current-serializer "Current serializer"))

     "App"
     (("m" projectile-rails-find-model        "Model")
      ("v" projectile-rails-find-view         "View")
      ("c" projectile-rails-find-controller   "Controller")
      ("h" projectile-rails-find-helper       "Helper")
      ("@" projectile-rails-find-mailer       "Mailer")
      ("j" projectile-rails-find-job          "Job")
      ("d" my/projectile-rails-find-decorator "Decorator")
      ("!" projectile-rails-find-validator    "Validator")
      ("a" my/projectile-rails-find-gql       "GraphQL")
      ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer   "Serializer"))

     "Assets"
     (("x" my/projectile-rails-find-typescript      "TS/TSX")
      ("X" my/projectile-rails-find-typescript-spec "TS/TSX spec")
      ("s" projectile-rails-find-stylesheet         "CSS"))

     "Other"
     (("n" projectile-rails-find-migration   "Migration")
      ("r" projectile-rails-find-rake-task   "Rake task")
      ("i" projectile-rails-find-initializer "Initializer")
      ("l" projectile-rails-find-lib         "Lib")
      ("p" projectile-rails-find-spec        "Spec")
      ("F" my/projectile-rails-find-factory  "Factory")
      ("t" projectile-rails-find-locale      "Translation"))

     "Single Files"
     (("R" projectile-rails-goto-routes      "Routes")
      ("G" projectile-rails-goto-gemfile     "Gemfile")
      ("T" projectile-rails-goto-schema      "Schema")
      ("f" my/projectile-goto-rubocop-config "rubocop.yml"))

     "Commands"
     (("1" projectile-rails-console   "Console")
      ("2" projectile-rails-dbconsole "DB")
      ("3" projectile-rails-generate  "Generate")
      ("4" projectile-rails-rake      "Rake"))))
  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails/body))

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html")))

(add-to-list 'auto-mode-alist '(".*\\.html\\.erb$" . web-mode))

(defun my/web-mode-hook ()
  (origami-mode 1)
  (subword-mode 1)
  (copilot-mode 1)
  (display-line-numbers-mode 1)
  (turn-on-smartparens-strict-mode)
  (lsp))

(add-hook 'web-mode-hook 'my/web-mode-hook)
