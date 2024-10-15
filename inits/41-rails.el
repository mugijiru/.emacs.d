(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)

(defun my/projectile-rails-find-typescript ()
  "Find a TS/TSX files."
  (interactive)
  (projectile-rails-find-resource
   "ts/tsx: "
   '(("client/" "\\(.+\\.tsx?\\)$"))
   "client/${filename}"))

(defun my/projectile-rails-find-typescript-spec ()
  "Find a TS/TSX test files."
  (interactive)
  (projectile-rails-find-resource
   "ts/tsx spec: "
   '(("spec/javascripts/" "\\(.+\\.spec.tsx?\\)$"))
   "spec/javascripts/${filename}"))

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-projectile-rails-find (:separator "-" :color blue :foreign-keys warn :title "Projectile Rails" :quit-key "q")
    ("Current"
     (("M" projectile-rails-find-current-model      "Current model")
      ("V" projectile-rails-find-current-view       "Current view")
      ("C" projectile-rails-find-current-controller "Current controller")
      ("H" projectile-rails-find-current-helper     "Current helper")
      ("P" projectile-rails-find-current-spec       "Current spec")
      ("Z" projectile-rails-find-current-serializer "Current serializer"))

     "App"
     (("m" projectile-rails-find-model           "Model")
      ("v" projectile-rails-find-view            "View")
      ("c" projectile-rails-find-controller      "Controller")
      ("h" projectile-rails-find-helper          "Helper")
      ("@" projectile-rails-find-mailer          "Mailer")
      ("!" projectile-rails-find-validator       "Validator")
      ;; ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer      "Serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript         "Javascript")
      ;; ("w" projectile-rails-find-component)
      ("x" my/projectile-rails-find-typescript      "TS/TSX")
      ("X" my/projectile-rails-find-typescript-spec "TS/TSX spec")
      ("s" projectile-rails-find-stylesheet         "CSS"))

     "Other"
     (("n" projectile-rails-find-migration    "Migration")
      ("r" projectile-rails-find-rake-task    "Rake task")
      ("i" projectile-rails-find-initializer  "Initializer")
      ("l" projectile-rails-find-lib          "Lib")
      ("p" projectile-rails-find-spec         "Spec")
      ("t" projectile-rails-find-locale       "Translation"))

     "Single Files"
     (("R" projectile-rails-goto-routes   "routes.rb")
      ("G" projectile-rails-goto-gemfile  "Gemfile")
      ("D" projectile-rails-goto-schema   "schema.rb"))

     "Commands"
     (("1" projectile-rails-console   "Console")
      ("2" projectile-rails-dbconsole "DB")
      ("3" projectile-rails-generate  "Generate")
      ("4" projectile-rails-rake      "Rake"))))
  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body))
