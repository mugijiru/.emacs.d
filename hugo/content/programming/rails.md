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


### TS/TSX Finder {#ts-tsx-finder}

`client` に格納しているフロントエンドのファイルを検索するコマンド

```emacs-lisp
(defun my/projectile-rails-find-typescript ()
  "Find a TS/TSX files."
  (interactive)
  (projectile-rails-find-resource
   "ts/tsx: "
   '(("client/" "\\(.+\\.tsx?\\)$"))
   "client/${filename}"))
```


### TS/TSX test files Finder {#ts-tsx-test-files-finder}

`spec/javascript` に格納しているフロントエンドのテストファイルを検索するコマンド

```emacs-lisp
(defun my/projectile-rails-find-typescript-spec ()
  "Find a TS/TSX test files."
  (interactive)
  (projectile-rails-find-resource
   "ts/tsx spec: "
   '(("spec/javascripts/" "\\(.+\\.spec.tsx?\\)$"))
   "spec/javascripts/${filename}"))
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
      ("D" projectile-rails-goto-schema   "schema.rb"))))
  (define-key projectile-rails-mode-map (kbd "C-c r") 'pretty-hydra-projectile-rails-find/body))
```

| Key | 効果                             | 備考                                                                                          |
|-----|--------------------------------|---------------------------------------------------------------------------------------------|
| M   | 現在のファイルに関連する Model を開く |                                                                                               |
| V   | 現在のファイルに関連する View を開く | キーが Vue ファイル検索とかぶってしまっていて現在使えない                                     |
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
| t   | I18n の翻訳ファイルを検索する    |                                                                                               |
| R   | routes.rb を開く                 |                                                                                               |
| G   | Gemfile を開く                   |                                                                                               |
| D   | Schema.rb を開く                 |                                                                                               |
