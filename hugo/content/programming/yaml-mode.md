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

合わせて [yaml-pro](https://github.com/zkry/yaml-pro) も導入している。こちらはレシピが el-get 本体にはないので自前で用意している

```emacs-lisp
(:name yaml-pro
 :website "https://github.com/zkry/yaml-pro"
 :description "provides conveniences for editing yaml"
 :type github
 :pkgname "zkry/yaml-pro"
 :depends (yaml))
```

そんで `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle yaml-pro)
```


## hook {#hook}

mode に対する hook は関数を定義してその中で呼びたいコードを書いていくようにしている。

lambda で書いてしまうと hook を弄りたい時に結構面倒なのだけど関数を定義しておくと、その関数の中身を変更して評価しておくだけで
hook で動作する中身が変更できて便利。

とりあえず yaml-mode では以下のようにして
[lsp-mode]({{< relref "lsp-mode" >}}) と yaml-pro, [flycheck]({{< relref "flycheck" >}}), [highlight-indent-guides](https://github.com/DarthFennec/highlight-indent-guides) を有効にしている。

```emacs-lisp
(defun my/yaml-mode-hook ()
  (lsp)
  (yaml-pro-mode 1)
  (flycheck-mode 1)
  (highlight-indent-guides-mode 1))
```

で、その hook を最後に yaml-mode-hook に追加している。

```emacs-lisp
(add-hook 'yaml-mode-hook 'my/yaml-mode-hook)
```


## treesit-auto で yaml-ts-mode を有効化させない {#treesit-auto-で-yaml-ts-mode-を有効化させない}

yaml-ts-mode はインデント周りの挙動が気に入らないので昔ながらの yaml-mode.el を使い続けている。

で treesit-auto を入れていると自動で yaml-ts-mode にしてくれやがるのでそれをさせない設定を入れている

```emacs-lisp
(with-eval-after-load 'treesit-auto
  (delete 'yaml treesit-auto-langs))
```
