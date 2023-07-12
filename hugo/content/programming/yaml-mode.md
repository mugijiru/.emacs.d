+++
title = "yaml-mode"
draft = false
+++

## 概要 {#概要}

[yaml-mode](https://github.com/yoshiki/yaml-mode) は yaml を編集する時のメジャーモード。インデントを調整しやすい。


## インストール {#インストール}

いつも通り el-get でインストール

```emacs-lisp
(el-get-bundle yaml-mode)
```


## hook {#hook}

mode に対する hook は関数を定義してその中で呼びたいコードを書いていくようにしている。

lambda で書いてしまうと hook を弄りたい時に結構面倒なのだけど関数を定義しておくと、その関数の中身を変更して評価しておくだけで
hook で動作する中身が変更できて便利。

とりあえず yaml-mode では以下のようにして
[highlight-indent-guides](https://github.com/DarthFennec/highlight-indent-guides) を有効にしている。

```emacs-lisp
(defun my/yaml-mode-hook ()
  (lsp 1)
  (highlight-indent-guides-mode 1))
```

で、その hook を最後に yaml-mode-hook に追加している。

```emacs-lisp
(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)
```
