+++
title = "Neotree"
tags = ["replacement"]
draft = false
+++

## 概要 {#概要}

[Neotree](https://github.com/jaypei/emacs-neotree) は Emacs でフォルダのツリー表示ができるやつ。メンテは活発じゃないようなので、その内乗り換えたい。


## レシピ {#レシピ}

Neotree でメンテされているのは dev ブランチだけど
el-get の公式のレシピでは master ブランチを見ているので自前で recipe を用意してそれを使っている。

```emacs-lisp
(:name emacs-neotree-dev
       :website "https://github.com/jaypei/emacs-neotree"
       :description "An Emacs tree plugin like NerdTree for Vim."
       :type github
       :branch "dev"
       :pkgname "jaypei/emacs-neotree")
```


## インストール {#インストール}

上に書いたレシピを使ってインストールしている。

```emacs-lisp
(el-get-bundle emacs-neotree-dev)
```


## 使わなくなったコード {#使わなくなったコード}

元々設定していたが、
counsel-projectile を使ってると
projectile-switch-project-action を設定していても反映されず意味がないのに気付いたので使わなくなった

<https://github.com/mugijiru/.emacs.d/pull/183/files#r541843206>

```emacs-lisp
(setq projectile-switch-project-action 'neotree-projectile-action)
```


## テーマの設定 {#テーマの設定}

GUI で起動している時はアイコン表示しそうでない場合は ▾ とかで表示する

```emacs-lisp
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
```

のだけど、実際に今使ってるやつだともっとグラフィカルな表示なので
all-the-icons の設定で上書きしている気がするので要確認


## major-mode-hydra {#major-mode-hydra}

いちいちキーバインドを覚えてられないので
[major-mode-hydra](https://github.com/jerrypnz/major-mode-hydra.el) を使って主要なキーバインドは [hydra](https://github.com/abo-abo/hydra) で使えるようにしている。

とはいえ、この文書を書く前日ぐらいに設定しているのでまだ使い慣れてないというか、ほとんど使えてない。

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define neotree-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-octicon "list-unordered") " Neotree"))
    ("Nav"
     (("u"   neotree-select-up-node   "Up")
      ("g"   neotree-refresh          "Refresh")
      ("Q"   neotree-hide             "Hide"))

     "File"
     (("a"   neo-open-file-ace-window "Ace")
      ("N"   neotree-create-node      "Create")
      ("R"   neotree-rename-node      "Rename")
      ("C"   neotree-copy-node        "Copy")
      ("D"   neotree-delete-node      "Delete")
      ("SPC" neotree-quick-look       "Look")
      ;; ("d" neo-open-dired "Dired")
      ;; ("O" neo-open-dir-recursive   "Recursive")
      )
     "Toggle"
     (("z" neotree-stretch-toggle     "Size"        :toggle (not (neo-window--minimize-p)))
      ("h" neotree-hidden-file-toggle "Hidden file" :toggle neo-buffer--show-hidden-file-p)))))
```


### キーバインド {#キーバインド}


#### ナビゲーション {#ナビゲーション}

| Key | 効果        |
|-----|-----------|
| u   | 上のノードに移動 |
| g   | 再描画      |
| Q   | Neotree を隠す |


#### ファイル操作 {#ファイル操作}

| Key | 効果                                     |
|-----|----------------------------------------|
| a   | ファイルを開く。その際に ace-window で開く window を指定する |
| N   | 新しいノードを作る                       |
| R   | ノードの名前を変える                     |
| C   | ノードのコピー                           |
| D   | ノードの削除                             |
| SPC | クイックルック                           |


#### Toggle {#toggle}

| Key | 効果                      |
|-----|-------------------------|
| z   | Neotree のサイズを大きくしたり小さくしたり |
| h   | 隠しファイルを表示したり隠したり |
