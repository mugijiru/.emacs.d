(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)

(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define pretty-hydra-projectile-rails-find (:separator "-" :color blue :foreign-keys warn :title "Projectile Rails" :quit-key "q")
    ("Current"
     (("M" projectile-rails-find-current-model      "current model")
      ("V" projectile-rails-find-current-view       "current view")
      ("C" projectile-rails-find-current-controller "current controller")
      ("H" projectile-rails-find-current-helper     "current helper")
      ("P" projectile-rails-find-current-spec       "current spec")
      ("Z" projectile-rails-find-current-serializer "current serializer"))

     "App"
     (("m" projectile-rails-find-model "model")
      ("v" projectile-rails-find-view  "view")
      ("c" projectile-rails-find-controller "controller")
      ("h" projectile-rails-find-helper "helper")
      ("@" projectile-rails-find-mailer "mailer")
      ;; ("y" projectile-rails-find-layout "Layout")
      ("z" projectile-rails-find-serializer "serializer"))

     "Assets"
     (("j" projectile-rails-find-javascript "Javascript")
      ;; ("w" projectile-rails-find-component)
      ("s" projectile-rails-find-stylesheet "CSS"))

     "Other"
     (("n" projectile-rails-find-migration "Migration")
      ("r" projectile-rails-find-rake-task "Rake task")
      ("i" projectile-rails-find-initializer "Initializer")
      ("l" projectile-rails-find-lib "Lib")
      ("p" projectile-rails-find-spec "Spec")
      ("t" projectile-rails-find-locale "Translation")))))
