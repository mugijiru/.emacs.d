+++
title = "all-the-icons"
draft = false
+++

## 概要 {#概要}

[all-the-icons](https://github.com/domtronn/all-the-icons.el) は Emacs で様々なアイコンを表示できるようにして華やかにしてくれるパッケージです。
[Neotree]({{< relref "neotree" >}}) などでも対応していてアイコンでファイルの種類が表示されるようになってモダンな雰囲気が出ます。


## インストール <span class="tag"><span class="improvement">improvement</span></span> {#インストール}

いつも通り el-get-bundle で入れている。明示的に require している理由は忘れました。

```emacs-lisp
(el-get-bundle all-the-icons)
(require 'all-the-icons)
```


## フォントのインストール {#フォントのインストール}

以下のコマンドを叩くことでフォントをインストールすることができる。
all-the-icons のインストール直後に叩いておいたら普段は叩かなくて良いはず。

```emacs-lisp
(all-the-icons-install-fonts)
```

all-the-icons の更新後は叩いた方がいいかもしれない


## キーバインド <span class="tag"><span class="improvement">improvement</span></span> {#キーバインド}

キーバインドは覚えられないし、使えるキーも大分埋まってるので、
pretty-hydra を使って all-the-icons 用の Hydra を用意している。

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define all-the-icons-hydra (:separator "-" :title "All the icons" :exit t :quit-key "q")
    ("Insert"
     (("a" all-the-icons-insert-alltheicon "All the icons")
      ("f" all-the-icons-insert-fileicon   "File icons")
      ("F" all-the-icons-insert-faicons    "FontAwesome")
      ("m" all-the-icons-insert-material   "Material")
      ("o" all-the-icons-insert-octicon    "Octicon")
      ("w" all-the-icons-insert-wicon      "Weather")
      ("*" all-the-icons-insert            "All")))))
```

| Key | 効果                             |
|-----|--------------------------------|
| a   | all-the-icons で追加されてるアイコンを検索して挿入 |
| f   | ファイルアイコンを検索して挿入   |
| F   | FontAwesome アイコンを検索して挿入 |
| m   | Material アイコンを検索して挿入  |
| o   | Octicon のアイコンを検索して挿入 |
| w   | 天気アイコンを検索して挿入       |
| \*  | 全てのアイコンを検索して挿入     |

フォントのインストールコマンドもここに収めてしまうのが良さそうな気がする
