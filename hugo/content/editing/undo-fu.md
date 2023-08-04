+++
title = "undo-fu"
draft = false
+++

## 概要 {#概要}

[undo-fu](https://github.com/emacsmirror/undo-fu) はシンプルな undo/redo 機能を提供してくれるやつ。

昔はもっと色々できる [undo-tree](https://www.emacswiki.org/emacs/UndoTree) を使っていたけどそっちにバグがあるっぽいので乗り換えた。


## インストール {#インストール}

レシピは自前で用意している

```emacs-lisp
(:name undo-fu
       :website "https://codeberg.org/ideasman42/emacs-undo-fu"
       :description "Simple, stable linear undo with redo for Emacs."
       :type git
       :url "https://codeberg.org/ideasman42/emacs-undo-fu.git")
```

そしていつも通り `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle undo-fu)
```


## キーバインド {#キーバインド}

別の場所で定義しているけど、以下のキーバインドにしている。

| Key   | 効果 |
|-------|----|
| C-/   | undo |
| C-M-/ | redo |
