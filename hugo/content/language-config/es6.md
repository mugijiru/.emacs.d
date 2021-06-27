+++
title = "es6"
draft = false
+++

## 概要 {#概要}

ES5 以前ではない JS を書くための設定。
es6 といいつつ ES2016(ES7) などもこの設定のまま書いている。

[sprockets-es6](https://github.com/TannerRogalsky/sprockets-es6) を使って ES6 対応をしていた時に
es6 という拡張子を使っていたのでこのファイル名になっている。


## インストール {#インストール}

es6 はつまり JS なのでとりあえず el-get で js2-mode を入れている。

```emacs-lisp
(el-get-bundle js2-mode)
```


## Hook {#hook}

-   flycheck を有効にしてリアルタイムに文法チェックをしている
    -   また `javascript-eslint` を使いたいので他2つは disable にしている
-   company-mode で補完できるようにしている
-   smartparens-strict-mode でカッコなどの入力補助をしている
-   インデントは空白2文字としている

<!--listend-->

```emacs-lisp
(defun my/js2-mode-hook ()
  (flycheck-mode 1)
  (setq flycheck-disabled-checkers '(javascript-standard javascript-jshint))

  (company-mode 1)
  (turn-on-smartparens-strict-mode)

  (setq js2-basic-offset 2))
```

という Hook 用関数を用意しておいて

```emacs-lisp
(add-hook 'js2-mode-hook 'my/js2-mode-hook)
```

という感じで js2-mode-hook に追加している。

Lambda で一括でやる方法もあるけども、関数名つけて分離しておくと中身を簡単に入れ替えられて便利。


## es6 を js2-mode で扱うようにする {#es6-を-js2-mode-で扱うようにする}

```emacs-lisp
(add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
```


## 他に気になるツール {#他に気になるツール}


### xref-js2 {#xref-js2}

<https://github.com/js-emacs/xref-js2>

コード間の移動が楽になるかもしれない。けど dumb-jump があるから別に要らない気もする


### js2-refactor {#js2-refactor}

<https://github.com/js-emacs/js2-refactor.el>

リファクタリングツール。キーバインドは覚えるのつらそうだから Hydra を用意する必要がありそう。


### skewer-mode {#skewer-mode}

<https://github.com/skeeto/skewer-mode>

Web ブラウザと連携して JS の評価をしたりとかしてくれたり一部の変更を反映してくれたりするらしい。

保存したら自動リロードされる環境はともかくそうじゃない環境だと楽かもしねあい。


### js-import {#js-import}

<https://github.com/jakoblind/js-import>

import を書くのを楽にしてくれるっぽい。


### indium {#indium}

<https://github.com/NicolasPetton/indium>

Node.js と連携してステップ実行とかができるようになるらしい。便利そう。
