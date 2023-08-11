+++
title = "with-simulated-input"
draft = false
weight = 1
+++

## 概要 {#概要}

[with-simulated-input](https://github.com/DarwinAwardWinner/with-simulated-input) は入力処理をシミュレートするためのプラグイン。

公式のドキュメントにあるように

```emacs-lisp
(with-simulated-input
    "hello SPC world RET"
  (read-string "Say hello to the world: "))
```

を評価すると
read-string に対して「hello world」を入力したことになるので
echo エリアに「hello world」と表示される。

これで何が嬉しいかというと
Emacs Lisp でやっていることはインタラクティブな部分が大きいのでそういった要素をテストできるようになる。

具体的な使用例は [test:my/org-todo]({{< relref "my-org-commands-test#test-my-org-todo" >}}) で示す。


## インストール {#インストール}

レシピは自前で用意している

```emacs-lisp
(:name with-simulated-input
       :type github
       :description "A macro to simulate user input non-interactively."
       :pkgname "DarwinAwardWinner/with-simulated-input"
       :minimum-emacs-version (24 4))
```

そして `el-get-bundle` で GitHub からインストールしている

```emacs-lisp
(el-get-bundle DarwinAwardWinner/with-simulated-input)
```
