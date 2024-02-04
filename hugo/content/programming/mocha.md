+++
title = "Mocha"
tags = ["Deprecated"]
draft = false
+++

## 概要 {#概要}

[Mocha](https://mochajs.org/) は JS のテストフレームワークの1つ。
Jest より前はこっちはよく使われてた

というわけで設定していたのだけど、今はもう使ってない。

ひょっとしたらまた使うことがあるかもしれないのでドキュメントには残しておいて
tangle による出力を停止する。


## mocha.el {#mocha-dot-el}


### インストール {#インストール}

レシピは自前で用意していた

```emacs-lisp
(:name mocha
       :description "Emacs mode for running mocha tests"
       :website "https://github.com/scottaj/mocha.el"
       :type github
       :pkgname "scottaj/mocha.el")
```

そしていつも通り `el-get-bundle` でインストールしていた

```emacs-lisp
(el-get-bundle mocha)
```


## テスト実行コマンド {#テスト実行コマンド}

mocha のテストファイルかどうかを判定してそうだったら
mocha としてテストを実行するコマンドを用意していた

```emacs-lisp
(defun my/mocha-test-file ()
  (interactive)
  (if my/mocha-enable-p
      (mocha-test-file)))
```
