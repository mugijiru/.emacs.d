(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)

(defun my/projectile-rails-find-uploader ()
  "Find a Uploader."
  (interactive)
  (projectile-rails-find-resource
   "uploader: "
   '(("app/uploaders/" "\\(.+\\)\\.rb$"))
   "app/uploaders/${filename}.rb"))

(defun my/projectile-rails-find-admin ()
  "Find a ActiveAdmin file."
  (interactive)
  (projectile-rails-find-resource
   "admin: "
   '(("app/admin/" "\\(.+\\)\\.rb$"))
   "app/admin/${filename}.rb"))

(defun my/projectile-rails-find-form-object ()
  "Find a Form Object."
  (interactive)
  (projectile-rails-find-resource
   "form object: "
   '(("app/models/forms/" "\\(.+\\)\\.rb$"))
   "app/models/forms/${filename}.rb"))

(defun my/projectile-rails-find-vue ()
  "Find a Vue."
  (interactive)
  (projectile-rails-find-resource
   "vue: "
   '(("app/javascript/" "\\(.+\\)\\.vue$"))
   "app/javascript/${filename}.vue"))

(defun my/projectile-rails-find-webpack-js ()
  "Find a Webpack js."
  (interactive)
  (projectile-rails-find-resource
   "webpack js: "
   '(("app/javascript/" "\\(.+\\)\\.js$"))
   "app/javascript/${filename}.js"))

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
      ("a" my/projectile-rails-find-admin        "ActiveAdmin")
      ("f" my/projectile-rails-find-form-object  "Form object")
      ("@" projectile-rails-find-mailer          "Mailer")
      ("V" my/projectile-rails-find-vue          "Vue")
      ("J" my/projectile-rails-find-webpack-js   "Webpack js")
      ("u" my/projectile-rails-find-uploader     "Controller")
      ("!" projectile-rails-find-validator       "Validator")
      ;; ("y" projectile-rails-find-layout       "Layout")
      ("z" projectile-rails-find-serializer      "Serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript  "Javascript")
      ;; ("w" projectile-rails-find-component)
      ("s" projectile-rails-find-stylesheet  "CSS"))

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
      ("D" projectile-rails-goto-schema   "schema.rb"))))
  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body))
