+++
title = "2. org-babel"
draft = false
+++

## 概要 {#概要}

ここでは org-babel の設定をまとめている。


## org-export-blocks-format-plantuml {#org-export-blocks-format-plantuml}

org-mode で PlantUML の図を出力する拡張を入れている。

```emacs-lisp
(el-get-bundle org-export-blocks-format-plantuml)
```

のだけれど
<https://www.emacswiki.org/emacs/org-export-blocks-format-plantuml.el>
を見ると Obsolute と書いてますね。今度消さなきゃ。


## org-babel で評価可能な言語の指定 {#org-babel-で評価可能な言語の指定}

なんか普段から使いそうな奴をとりあえず選定しているつもり。

```emacs-lisp
(org-babel-do-load-languages 'org-babel-load-languages
                             '((plantuml . t)
                               (sql . t)
                               (gnuplot . t)
                               (emacs-lisp . t)
                               (shell . t)
                               (js . t)
                               (ruby . t)))
```

js, ruby
: 仕事でメインで使ってる言語なので入れている。

shell
: 入れてる方が便利そう、ぐらいの雑な理由。

sql
: メモしておいて手元から実行できると便利そう

plantuml
: 図の出力。一番使ってる。

gnuplot
: 趣味で入れてみているけど実際使う機会ほとんどないよなって気がしてきている。


## org-babel-execute 後に画像を再表示 {#org-babel-execute-後に画像を再表示}

PlantUML の処理をすることが多いので以下の hook を設定することで実行後に画像を再表示するようにしている

```emacs-lisp
(add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images)
```


## org-babel の非同期実行 {#org-babel-の非同期実行}

非同期に org-babel の source を実行するために
[ob-async](https://github.com/astahlman/ob-async) を入れている

```emacs-lisp
(el-get-bundle ob-async)
(require 'ob-async)
```

で、ob-async を何のために入れているかというと PlantUML の図の出力である。画像まで作成するからね、時間かかりそうだしね。

そんで、その時に `org-plantuml-jar-path` を強制的に指定している。

```emacs-lisp
(add-hook 'ob-async-pre-execute-src-block-hook
      '(lambda ()
         (setq org-plantuml-jar-path "~/bin/plantuml.jar")))
```

多分 custom-set-variables でちゃんと設定したらいいんだろうなあ。
