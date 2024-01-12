+++
title = "Mocha"
draft = false
+++

## 概要 {#概要}

[Mocha](https://mochajs.org/) は JS のテストフレームワークの1つ。
Jest より前はこっちはよく使われてた


## mocha.el {#mocha-dot-el}


### インストール {#インストール}

レシピは自前で用意している

```emacs-lisp
(:name mocha
       :description "Emacs mode for running mocha tests"
       :website "https://github.com/scottaj/mocha.el"
       :type github
       :pkgname "scottaj/mocha.el")
```

そしていつも通り `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle mocha)
```


## テスト実行コマンド {#テスト実行コマンド}

mocha のテストファイルかどうかを判定してそうだったら
mocha としてテストを実行するコマンドを用意している。

```emacs-lisp
(defun my/mocha-test-file ()
  (interactive)
  (if my/mocha-enable-p
      (mocha-test-file)))
```

けど今 mocha 使ってないからこれ使ってないんだよねえ……
