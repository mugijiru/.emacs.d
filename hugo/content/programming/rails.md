+++
title = "rails"
draft = false
+++

## 概要 {#概要}

Rails 開発関係だけど Ruby 開発とはちょっと違う設定をここに書いている。


## 関連パッケージのインストール {#関連パッケージのインストール}

テンプレートエンジンには haml を使っているので [haml-mode](https://github.com/nex3/haml-mode) を入れていてファイルナビゲーションには [projectile]({{< relref "projectile" >}}) の拡張である [projectile-rails](https://github.com/asok/projectile-rails) を利用している。

```emacs-lisp
(el-get-bundle haml-mode)
(el-get-bundle projectile-rails)
(projectile-rails-global-mode 1)
```


## projectile-rails 用のコマンド追加 {#projectile-rails-用のコマンド追加}

自身のプロジェクトだと少しナビゲーション用のコマンドが不足していたので
projectile-rails の実装を参考にコマンドを追加している


### Uploader Finder {#uploader-finder}

`app/uploaders` に格納している upload に関連するファイルを検索するコマンド

```emacs-lisp
(defun my/projectile-rails-find-uploader ()
  "Find a Uploader."
  (interactive)
  (projectile-rails-find-resource
   "uploader: "
   '(("app/uploaders/" "\\(.+\\)\\.rb$"))
   "app/uploaders/${filename}.rb"))
```


### Admin Finder {#admin-finder}

Active Admin 用のファイルを検索するためのコマンド

```emacs-lisp
(defun my/projectile-rails-find-admin ()
  "Find a ActiveAdmin file."
  (interactive)
  (projectile-rails-find-resource
   "admin: "
   '(("app/admin/" "\\(.+\\)\\.rb$"))
   "app/admin/${filename}.rb"))
```


### Form Object Finder {#form-object-finder}

Form Object を探すためのコマンド

```emacs-lisp
(defun my/projectile-rails-find-form-object ()
  "Find a Form Object."
  (interactive)
  (projectile-rails-find-resource
   "form object: "
   '(("app/models/forms/" "\\(.+\\)\\.rb$"))
   "app/models/forms/${filename}.rb"))
```


### Vue Finder {#vue-finder}

Vue.js の単一ファイルコンポーネントを探すためのコマンド

```emacs-lisp
(defun my/projectile-rails-find-vue ()
  "Find a Vue."
  (interactive)
  (projectile-rails-find-resource
   "vue: "
   '(("app/javascript/" "\\(.+\\)\\.vue$"))
   "app/javascript/${filename}.vue"))
```


### Webpacker 管理の JS 検索コマンド {#webpacker-管理の-js-検索コマンド}

Webpacker で JS を管理していたりもするので必要だった

```emacs-lisp
(defun my/projectile-rails-find-webpack-js ()
  "Find a Webpack js."
  (interactive)
  (projectile-rails-find-resource
   "webpack js: "
   '(("app/javascript/" "\\(.+\\)\\.js$"))
   "app/javascript/${filename}.js"))
```


## キーバインド {#キーバインド}

もちろん基本的にコマンドなんて覚えられないのでいつも通り Hydra を定義して大体キーバインドは忘れている。

なおこの Hydra は Rails のファイルを開いている時には `C-c r` で起動するようにしている。これは通常のセットアップで prefix としてこう設定するといいよ、みたいに書かれているのを流用している。
<https://github.com/asok/projectile-rails#keymap-prefix>

```emacs-lisp
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
```

| Key | 効果                             | 備考                                                                                              |
|-----|--------------------------------|-------------------------------------------------------------------------------------------------|
| M   | 現在のファイルに関連する Model を開く |                                                                                                   |
| V   | 現在のファイルに関連する View を開く | キーが Vue ファイル検索とかぶってしまっていて現在使えない                                         |
| C   | 現在のファイルに関連する Controller を開く |                                                                                                   |
| H   | 現在のファイルに関連する Helper を開く |                                                                                                   |
| P   | 現在のファイルに関連する Spec を開く |                                                                                                   |
| Z   | 現在のファイルに関連する Serializer を開く | [ActiveModelSerializer](https://github.com/rails-api/active%5Fmodel%5Fserializers) を使ってるプロジェクトがある |
| m   | Model ファイルを検索する         |                                                                                                   |
| v   | View ファイルを検索する          |                                                                                                   |
| c   | Controller ファイルを検索する    |                                                                                                   |
| h   | Helper ファイルを検索する        |                                                                                                   |
| a   | ActiveAdmin のファイルを検索する |                                                                                                   |
| f   | Form Object ファイルを検索する   |                                                                                                   |
| @   | ActionMailer ファイルを検索する  |                                                                                                   |
| V   | Vue の単一ファイルコンポーネントファイルを検索する |                                                                                                   |
| J   | Webpacker 管理の JS ファイルを検索する |                                                                                                   |
| u   | Uploader ファイルを検索する      |                                                                                                   |
| !   | Validator ファイルを検索する     |                                                                                                   |
| z   | Serializer ファイルを検索する    |                                                                                                   |
| j   | assets 配架の JS ファイルを検索する |                                                                                                   |
| s   | SCSS ファイルを検索する          |                                                                                                   |
| n   | migration ファイルを検索する     |                                                                                                   |
| r   | rake ファイルを検索する          |                                                                                                   |
| i   | config/initializers 以下のファイルを検索する |                                                                                                   |
| l   | lib 以下のファイルを検索する     |                                                                                                   |
| p   | rspec ファイルを検索する         |                                                                                                   |
| t   | I18n の翻訳ファイルを検索する    |                                                                                                   |
| R   | routes.rb を開く                 |                                                                                                   |
| G   | Gemfile を開く                   |                                                                                                   |
| D   | Schema.rb を開く                 |                                                                                                   |
