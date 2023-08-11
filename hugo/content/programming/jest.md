+++
title = "Jest"
draft = false
+++

## 概要 {#概要}

[Jest](https://jestjs.io/ja/) は JavaScript のテスティングフレームワークの1つ。なんか大体オールインワンな感じで最近はデファクトっぽい人気なやつ。


### jest-test-mode {#jest-test-mode}

[jest-test-mode](https://github.com/rymndhng/jest-test-mode/tree/master) は Emacs 上から Jest のテストを手軽に実行できるようにしてくれるやつ。


#### インストール {#インストール}

まず el-get のレシピが公式では置かれていないので自前で用意

```emacs-lisp
(:name jest-test-mode
       :website "https://github.com/rymndhng/jest-test-mode/tree/3126c5c5c5632da639ea34867a7342d4410d78aa"
       :description "Emacs minor mode for running jest."
       :type github
       :pkgname "rymndhng/jest-test-mode"
       :minimum-emacs-version "25.1")
```

そしてそれを `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle jest-test-mode)
```


#### keymap {#keymap}

デフォルトのキーマップ以外にも
`C-c C-c` でテストできる方が手癖でテストを実行できて便利なので
jest-test-mode-map に keybind を追加している

```emacs-lisp
(with-eval-after-load 'jest-test-mode
  (let ((keymap jest-test-mode-map))
    (define-key keymap (kbd "C-c C-c") 'jest-test-run-at-point)))
```


#### .dir-locals.el {#dot-dir-locals-dot-el}

Jest でテストを書いているプロジェクトのテストファイルを詰めているフォルダの.dir-locals.el に以下のように書くことでそれらのコードを開いた時に `jest-test-mode` が自動的に有効になるようにしている

```emacs-lisp
((web-mode        . ((eval . (jest-test-mode))))
 (typescript-mode . ((eval . (jest-test-mode)))))
```


### その他 {#その他}

類似品に [emacs-jest](https://github.com/Emiller88/emacs-jest) というのもあるが、こちらは el-get で入れようとしても jest-traverse-test.el の byte compile でエラーになるので利用を諦めた
