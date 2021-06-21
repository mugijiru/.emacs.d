+++
title = "helm"
draft = false
+++

## 概要 {#概要}

[helm](https://github.com/emacs-helm/helm) は anything.el の後継であり、インクリメンタルに候補の絞り込みをしたりする UI を提供する便利なパッケージ。

[peco](https://github.com/peco/peco) とか [fzf](https://github.com/junegunn/fzf) とかと似ているっちゃ似ているかな? fzf 使ったことないけど。

一時期開発が止まってるようだったけど最近(2021年)はまた更新が活発になっている。

ただ、麦汁さんは ivy に乗り換えようとしているので helm の設定は頑張っていない。
helm-for-files が便利なのでまだ捨てられてないけど……。


## インストール {#インストール}

helm で使いたい拡張として
[helm-descbinds](https://github.com/emacs-helm/helm-descbinds) と [helm-ag](https://github.com/emacsorphanage/helm-ag) というのがあるのでそれらも同時に入れている。

```emacs-lisp
(el-get-bundle helm)
(el-get-bundle helm-descbinds)
(el-get-bundle helm-ag)
```

ただ descbinds は counsel-descbinds に置き換えたし
helm-ag ももう使ってない気がする


## 設定 {#設定}

オススメの設定が helm に同梱されている helm-config に入ってるのでまずはそれを読み込んでいる。

```emacs-lisp
(require 'helm-config)
```

また helm-descbinds を使えるように有効にしている。けど、上にも書いたけどもう counsel-descbinds に置き換えちゃったのよね……。

```emacs-lisp
(helm-descbinds-mode)
```

あとは helm-migemo-mode というのを有効にしている。これがあると helm で検索する時に migemo れて便利。

```emacs-lisp
(helm-migemo-mode 1)
```

ivy の方でも migemo 対応したいけどまだできてない……。


## その他 {#その他}

helm 系の設定は他の設定にも色々影響も大きそうなので読み込み順は結構早いタイミングにしている(init-loader で 20 を prefix にしている)
