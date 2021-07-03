+++
title = "Ember.js"
draft = false
+++

## 概要 {#概要}

Ember.js 用の Emacs の拡張としては
`ember-mode` と `handlebars-mode` が存在する


## ember-mode {#ember-mode}

[ember-mode](https://github.com/madnificent/ember-mode) は
Ember.js アプリケーションのファイルナビゲーションや生成を行ってくれるモード。実は麦汁さんは使えてない。

インストールするだけではダメで、
ember-mode を明示的に起動しないといけない。

そのためには dir-locals を使うとか
projectile なんかがやってるようにフォルダ構成から判定させるみたいなことが必要そう。だるい。

というわけで死蔵中。

ついでにいうとキーバインドもだるい系なので使う時は Hydra を用意した方が良さそう

```emacs-lisp
(el-get-bundle madnificent/ember-mode)
```


## handlebars-mode {#handlebars-mode}

[handlebars-mode](https://github.com/danielevans/handlebars-mode) は Ember.js のテンプレートエンジンとして採用されている
Handlebars を書くためのモード。

syntax highlight と、いくつかの編集機能を備えている。が、今のところ麦汁さんは syntax highlight しか使えてない。

編集コマンドは [major-mode-hydra](https://github.com/jerrypnz/major-mode-hydra.el) で使えるようにしてあげれば良さそう

```emacs-lisp
(el-get-bundle handlebars-mode)
```
