+++
title = "rspec-mode"
draft = false
+++

## 概要 {#概要}

[rspec-mode](https://github.com/pezra/rspec-mode) は Emacs で RSpec を実行したりする時に便利なパッケージ。といいつつ麦汁さんはちゃんと使いこなしていない……


## インストール {#インストール}

```emacs-lisp
(el-get-bundle rspec-mode)
```


## 有効化 {#有効化}

rspec 実行バッファで byebug などで止まった際に C-x C-q したら inf-ruby が動くようにしている。

```emacs-lisp
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
```

binding.pry は何故かまともに動かないので byebug か binding.irb 推奨。麦汁さんはいつも `debugger` とコードに入れて使っている。


## キーバインド {#キーバインド}

C-c C-c で開いている rspec ファイルのカーソルがある行のテストを実行できるようにしている。

```emacs-lisp
(define-key rspec-mode-map (kbd "C-c C-c") 'rspec-verify-single)
```

他にも色々な機能があるのだけどキーバインド未設定なのでこれだけしか使ってない。


## Docker 連携 {#docker-連携}

Docker と連携するように調整

```emacs-lisp
(custom-set-variables
 '(rspec-use-docker-when-possible t))
```
