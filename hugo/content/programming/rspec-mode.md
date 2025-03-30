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


## lsp-mode の imenu の override を無視する {#lsp-mode-の-imenu-の-override-を無視する}

lsp-mode が有効だと
`lsp--imenu-create-index` が `imenu-default-create-index-function` を override してしまうため
rspec-mode で用意されている `imenu-generic-expression` が使われなくなってしまい、
RSpec のファイルを開いて imenu を表示しようとしても
context とか describe とかが表示されない。

というわけでその override を無視するようにしている

```emacs-lisp
(defun my/rspec-imenu-create-index (_symbols)
  "Ignore LSP mode imenu create index function."
  (remove-function (local 'imenu-create-index-function) #'lsp--imenu-create-index)
  (funcall 'imenu-create-index-function)
  (advice-add 'imenu-create-index-function :override 'lsp--imenu-create-index))

(defun my/rspec-mode-hook ()
  "set rspec mode hook."
  (setq-local lsp-imenu-index-function 'my/rspec-imenu-create-index))

(add-hook 'rspec-mode-hook 'my/rspec-mode-hook)
```
