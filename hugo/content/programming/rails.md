+++
title = "rails"
draft = false
+++

## 概要 {#概要}

Rails 開発関係だけど Ruby 開発とはちょっと違う設定をここに書いている。


## 関連パッケージのインストール {#関連パッケージのインストール}

テンプレートエンジンには haml を使っているので [haml-mode](https://github.com/nex3/haml-mode) を入れていてファイルナビゲーションには [projectile]({{< relref "projectile" >}}) の拡張である [projectile-rails](https://github.com/asok/projectile-rails) を利用している。

```emacs-lisp
(el-get-bundle rails-i18n)
(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)
```

`rails-i18n` はレシピは自前で用意している。

```emacs-lisp
(:name rails-i18n
       :website "https://github.com/otavioschwanck/rails-i18n.el"
       :description "Search rails i18n using emacs and insert in your code."
       :type github
       :pkgname "otavioschwanck/rails-i18n.el")
```


## projectile-rails 用のコマンド追加 {#projectile-rails-用のコマンド追加}

自身のプロジェクトだと少しナビゲーション用のコマンドが不足していたので
projectile-rails の実装を参考にコマンドを追加している


### Service class files Finder {#service-class-files-finder}

`app/services` に格納しているサービスクラスのファイルを検索するコマンド

```emacs-lisp
(defun my/projectile-rails-find-service ()
  "Find a Service class file."
  (interactive)
  (projectile-rails-find-resource
   "Service: "
   '(("app/services/" "\\(.+\\.rb\\)$"))
   "app/services/${filename}"))
```


### Decorator files Finder {#decorator-files-finder}

`spec/javascript` に格納しているフロントエンドのテストファイルを検索するコマンド

```emacs-lisp
(defun my/projectile-rails-find-decorator ()
  "Find a Decorator file."
  (interactive)
  (projectile-rails-find-resource
   "Decorator: "
   '(("app/decorators/" "\\(.+\\.rb\\)$"))
   "app/decorators/${filename}"))
```


### FactoryBot files Finder {#factorybot-files-finder}

`spec/factories` に格納している FactoryBot の factory を検索するコマンド。
FactoryBot はよく使うので用意した

```emacs-lisp
(defun my/projectile-rails-find-factory ()
  "Find a FactoryBot file."
  (interactive)
  (projectile-rails-find-resource
   "Factory: "
   '(("spec/factories/" "\\(.+\\)\\.rb$"))
   "spec/factories/${filename}.rb"))
```


### その他 {#その他}

一部公開してない finder は別ファイルに格納しているのでそれを load するようにしている

```emacs-lisp
(my/load-config "projectile-finders")
```


## キーバインド {#キーバインド}

もちろん基本的にコマンドなんて覚えられないのでいつも通り Hydra を定義して大体キーバインドは忘れている。

なおこの Hydra は Rails のファイルを開いている時には `C-c r` で起動するようにしている。これは通常のセットアップで prefix としてこう設定するといいよ、みたいに書かれているのを流用している。
<https://github.com/asok/projectile-rails#keymap-prefix>

```emacs-lisp
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
```

| Key | 効果                             | 備考                                                                                          |
|-----|--------------------------------|---------------------------------------------------------------------------------------------|
| M   | 現在のファイルに関連する Model を開く |                                                                                               |
| V   | 現在のファイルに関連する View を開く |                                                                                               |
| C   | 現在のファイルに関連する Controller を開く |                                                                                               |
| H   | 現在のファイルに関連する Helper を開く |                                                                                               |
| P   | 現在のファイルに関連する Spec を開く |                                                                                               |
| Z   | 現在のファイルに関連する Serializer を開く | [ActiveModelSerializer](https://github.com/rails-api/active_model_serializers) を使ってるプロジェクトがある |
| m   | Model ファイルを検索する         |                                                                                               |
| v   | View ファイルを検索する          |                                                                                               |
| c   | Controller ファイルを検索する    |                                                                                               |
| h   | Helper ファイルを検索する        |                                                                                               |
| a   | ActiveAdmin のファイルを検索する |                                                                                               |
| f   | Form Object ファイルを検索する   |                                                                                               |
| @   | ActionMailer ファイルを検索する  |                                                                                               |
| V   | Vue の単一ファイルコンポーネントファイルを検索する |                                                                                               |
| J   | Webpacker 管理の JS ファイルを検索する |                                                                                               |
| u   | Uploader ファイルを検索する      |                                                                                               |
| !   | Validator ファイルを検索する     |                                                                                               |
| z   | Serializer ファイルを検索する    |                                                                                               |
| j   | assets 配架の JS ファイルを検索する |                                                                                               |
| s   | SCSS ファイルを検索する          |                                                                                               |
| n   | migration ファイルを検索する     |                                                                                               |
| r   | rake ファイルを検索する          |                                                                                               |
| i   | config/initializers 以下のファイルを検索する |                                                                                               |
| l   | lib 以下のファイルを検索する     |                                                                                               |
| p   | rspec ファイルを検索する         |                                                                                               |
| F   | FactoryBot の factory ファイルを検索する |                                                                                               |
| t   | I18n の翻訳ファイルを検索する    |                                                                                               |
| R   | routes.rb を開く                 |                                                                                               |
| G   | Gemfile を開く                   |                                                                                               |
| D   | Schema.rb を開く                 |                                                                                               |
| 1   | rails console を開く             |                                                                                               |
| 2   | rails dbconsole を開く           |                                                                                               |
| 3   | rails generate を実行する        |                                                                                               |
| 4   | rake を実行する                  |                                                                                               |


## erb の設定 {#erb-の設定}

erb を使うこともあるのでそれに向けての設定も入れている

まず lsp-mode で html-ls が動くようにするために lsp-language-id-confuguration の設定を変更している。

```emacs-lisp
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(".*\\.html\\.erb$" . "html")))
```

そしてファイルを開いた時には web-mode が起動するように調整している。

```emacs-lisp
(add-to-list 'auto-mode-alist '(".*\\.html\\.erb$" . web-mode))
```

また origami とか copilot とかも動くと便利そうなので有効化している

```emacs-lisp
(defun my/web-mode-hook ()
  (origami-mode 1)
  (subword-mode 1)
  (copilot-mode 1)
  (display-line-numbers-mode 1)
  (turn-on-smartparens-strict-mode)
  (lsp))

(add-hook 'web-mode-hook 'my/web-mode-hook)
```
