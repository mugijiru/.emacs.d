+++
title = "hydra"
draft = false
+++

## 概要 {#概要}

[Hydra](https://github.com/abo-abo/hydra) は Emacs の貴重なキーバインドを節約できる便利なパッケージ。

自分で定義した各 Hydra コマンドを実行するとそれに紐付くサブコマンドとそれらのキーバインド一覧を表示させることができるというやつ。


## インストール {#インストール}

Hydra 本体と関連パッケージをここでインスコしている


### Hydra 本体のインストール {#hydra-本体のインストール}

Hydra 本体は el-get で普通に入れている

```emacs-lisp
(el-get-bundle hydra)
```


### hydra-posframe のインストール {#hydra-posframe-のインストール}

Hydra は通常だと minibuffer あたりに表示されるけど画面の真ん中に表示される方が視線移動が少なくて便利なので
hydra-posframe を使って画面中央に表示されるようにしている。

インストールは el-get でやっているが recipe がないのでまずそれを用意。

```emacs-lisp
(:name hydra-posframe
       :description "a hydra extension which shows hydra hints on posframe."
       :type github
       :pkgname "Ladicle/hydra-posframe")
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle hydra-posframe)
```

そして Emacs の初期化処理が完了したタイミングでそれが使われるように after-init-hook で hydra-posframe を有効化している

```emacs-lisp
(add-hook 'after-init-hook 'hydra-posframe-enable)
```


### WebDAV Sync download の設定 {#webdav-sync-download-の設定}

作業管理用の org-mode のドキュメントは WebDAV サーバにも上げて
beorg でも使えるようにしているがそれを拾って来るためのコマンドを用意している。

```emacs-lisp
(defun my/download-from-beorg ()
  (interactive)
  (async-shell-command "java -jar ~/bin/webdav_sync1_1_9.jar -c ~/.config/webdav-sync/download.xml && notify-send 'WebDAV Sync' 'Downloaded from WebDAV'"))
```

簡単に `async-shell-command` を使って済ませている


### major-mode-hydra のインストール {#major-mode-hydra-のインストール}

自分以外で使っている人を見たことはないけど麦汁さんは [major-mode-hydra](https://github.com/jerrypnz/major-mode-hydra.el) というものを利用している。

これは major mode 用に簡単に Hydra の設定ができるというやつ。なので emacs-lisp-mode 用の Hydra とか
js2-mode 用の Hydra などを定義できて便利。

どちらの場合も `M-x major-mode-hydra` で起動するので迷わないで済むのも良い。

内部では同じリポジトリにある pretty-hydra というのを利用していてそいつが UI の定義をせずともそれなりの感じに Hydra のメニューを構築してくれるようになっている。これもズボラな麦汁さんは気に入っている。導入していても表示にこだわりたい場合は直接 `defhydra` したらいいだけだしね。

ってことでそれを el-get を使って GitHub からインストールしている。

```emacs-lisp
(el-get-bundle major-mode-hydra.el)
```

また pretty-hydra の表示フォーマットを変えるために
`pretty-hydra-default-title-body-format-spec` を使うようにしている

```emacs-lisp
(custom-set-variables '(pretty-hydra-default-title-body-format-spec "%s\n%s"))
```

なおレシピは自前で用意している

```emacs-lisp
(:name major-mode-hydra.el
       :website "https://github.com/jerrypnz/major-mode-hydra.el"
       :description "this package offers an alternative way to manage your major mode specific key bindings."
       :type github
       :pkgname "jerrypnz/major-mode-hydra.el")
```


## キーバインド {#キーバインド}

Hydra でいくつかのキーバインドを設定していて他の機能に属さないものはここでまとめてキーバインドを定義している。


### el-get {#el-get}

他の機能に属さないものは、と書いたな? ありゃ嘘だ。
el-get の Hydra はここで定義してしまっている。その内 el-get 用の設定ファイルにでも移動したい気がする。

```emacs-lisp
(pretty-hydra-define el-get-hydra (:separator "-" :title "el-get" :foreign-key warn :quit-key "q" :exit t)
  ("Install"
   (("i" el-get-install   "Install")
    ("I" el-get-reinstall "Re-install")
    ("D" el-get-remove    "Uninstall"))

   "Update"
   (("s" el-get-self-update  "Self Update")
    ("u" el-get-update       "Update")
    ("A" el-get-update-all   "Update All")
    ("r" el-get-reload       "Reload"))

   "Recipe"
   (("f" el-get-find-recipe-file              "Find recipe")
    ("E" el-get-elpa-build-local-recipes      "Build ELPA recipes")
    ("W" el-get-emacswiki-build-local-recipes "Build EmacsWiki recipes"))

   "Lock"
   (("C" el-get-lock-checkout  "Checkout")
    ("U" el-get-lock-unlock    "Unlock"))))
```

| Key | 効果                                        |
|-----|-------------------------------------------|
| i   | パッケージの新規インストール。正直このキー叩いた記憶がない |
| I   | パッケージの再インストール                  |
| D   | パッケージの削除                            |
| s   | el-get 自身のアップデート                   |
| u   | 指定パッケージのアップデート                |
| A   | 全パッケージのアップデート                  |
| r   | パッケージの読み直し                        |
| f   | パッケージのインストール用レシピファイルを開く |
| C   | 指定したパッケージを el-get-lock でロックされたバージョンをチェックアウト |
| U   | 指定したパッケージの el-get-lock のロックを解除 |


### Toggle Switches {#toggle-switches}

ここでは ON/OFF を切り替えるような機能のコントロールを行っている。

```emacs-lisp
(pretty-hydra-define
  toggle-hydra
  (:separator "-"
              :title (concat (all-the-icons-faicon "toggle-on") " Toggle Switches")
              :foreign-key warn
              :quit-key "q"
              :exit t)
  ("View"
   (("z" zoom-mode                 "zoom-mode"      :toggle zoom-mode)
    ("Z" toggle-frame-fullscreen   "Fullscreen"     :toggle (frame-parameter nil 'fullscreen))
    ("e" emojify-mode              "Emojify"        :toggle emojify-mode)
    ("B" blamer-mode               "Blamer"         :toggle blamer-mode)
    ("L" display-line-numbers-mode "Line Number"    :toggle display-line-numbers-mode)
    ("N" neotree-toggle            "Neotree"        :toggle (if (fboundp 'neo-global--window-exists-p) (neo-global--window-exists-p) nil)))

   "Mode Line"
   (("w" which-function-mode       "Which func"     :toggle which-func-mode)
    ("b" display-battery-mode      "Battery"        :toggle display-battery-mode))

   "Behavior"
   (("S" my/notify-slack-toggle    "Notify Slack"   :toggle my/notify-slack-enable-p)
    ("v" my/toggle-view-mode       "Readonly"       :toggle view-mode)
    ("f" flycheck-mode             "Flycheck"       :toggle flycheck-mode)
    ("A" auto-fix-mode             "Auto fix"       :toggle auto-fix-mode)
    ("^" subword-mode              "Subword"        :toggle subword-mode)
    ("(" smartparens-strict-mode   "strict parens"  :toggle smartparens-strict-mode)
    ("E" toggle-debug-on-error     "Debug on error" :toggle debug-on-error))))
```

| Key | 効果                                                                                   |
|-----|--------------------------------------------------------------------------------------|
| z   | [zoom-mode]({{< relref "zoom" >}}) のON/OFF切替。狭いディスプレイの時は ON にするが、大きいディスプレイだと OFF にしている |
| Z   | フルスクリーンの切替。狭いディスプレイの時は ON にするが、大きいディスプレイだと OFF にしている |
| e   | 常に絵文字に変換されると厳しい時があるので toggle できるようにしている                 |
| L   | 行番号表示の切替。邪魔になる時もあるので ON/OFF 切り替えている                         |
| N   | [Neotree]({{< relref "neotree" >}}) の表示切替。普段は邪魔なので OFF にしている        |
| w   | 関数名の表示が邪魔になることもありそうなので toggle できるようにしている               |
| b   | バッテリー表示モードの切替。OFF にしたことないな……                                   |
| S   | Slack 通知の切替。org-clock-in とかのタイミングで Slack に通知を飛ばしているが切る時もある |
| v   | view-mode にしたり戻したり。コードを眺めたい時などに ON にする                         |
| E   | エラー時のデバッグモードの切替。設定を弄ってる時はバックトレースある方が嬉しいよね     |


### Sub Tools {#sub-tools}

最初に起動した Hydra からは外してるけど、そこそこ使うコマンド群を適当に詰めてるやつ。

```emacs-lisp
(pretty-hydra-define
  subtools-hydra
  (:separator "-"
              :color teal
              :foreign-key warn
              :title (concat (all-the-icons-material "build") " Sub tools")
              :quit-key "q"
              :exit t)
  ("Describe"
   (("b" counsel-descbinds "Keybind")
    ("f" counsel-describe-function "Function")
    ("v" counsel-describe-variable "Variable")
    ;; ("P"   my/open-review-requested-pr "Open Requested PR")
    ("m" describe-minor-mode "Minor mode"))
   "Other"
   (("@" all-the-icons-hydra/body "List icons")
    ("w" which-key-show-top-level "Which key")
    ("D" my/download-from-beorg))))
```

| Key | 効果                                                  |
|-----|-----------------------------------------------------|
| b   | キーバインドを調べる                                  |
| f   | Emacs Lisp の関数を調べる                             |
| v   | Emacs Lisp の変数を調べる                             |
| m   | minor-mode を調べる                                   |
| @   | All the icons の Hydra を起動                         |
| w   | トップレベルのキーバインドを表示する                  |
| D   | beorg 連携に使ってる WebDAV サーバからダウンロード(Dropbox に移行して不要になった) |


### Text Scale {#text-scale}

文字サイズの切替用。たまに字を大きくしたりしたいので。

```emacs-lisp
(pretty-hydra-define text-scale-hydra (:separator "-" :title (concat (all-the-icons-material "text_fields") " Text Scale") :exit nil :quit-key "q")
  ("Scale"
   (("+" text-scale-increase "Increase")
    ("-" text-scale-decrease "Decrease")
    ("0" text-scale-adjust   "Adjust"))))
```

| Key | 効果        |
|-----|-----------|
| +   | 文字サイズを大きくする |
| -   | 文字サイズを小さくする |
| 0   | 文字サイズを元に戻す |


### Main {#main}

よく使うコマンドをまとめたやつ。
[key-chord]({{< relref "key-chord" >}}) を使って `jk` 同時押しで起動できるようにしている。

```emacs-lisp
(pretty-hydra-define pretty-hydra-usefull-commands (:separator "-" :color teal :foreign-key warn :title (concat (all-the-icons-material "build") " Usefull commands") :quit-key "q")
  ("File"
   (("p" projectile-hydra/body "Projectile")
    ("f" counsel-find-file     "Find File")
    ("d" counsel-find-dir      "Find Dir")
    ("r" counsel-recentf       "Recentf")
    ("L" counsel-locate        "Locate"))

   "Edit"
   (("a" align-regexp "Align Regexp")
    ("[" origami-hydra/body "Origami")
    (";" comment-dwim "Comment"))

   "Code"
   (("G" counsel-projectile-rg            "Grep")
    ("j" dumb-jump-pretty-hydra/body      "Dumb jump")
    ("g" avy-hydra/body                   "Avy")
    ("l" pretty-hydra-lsp/body            "LSP")
    ("i" counsel-imenu                    "imenu")
    ("y" yasnippet-hydra/body             "Yasnippet")
    ("B" browse-at-remote                 "Browse")
    ("C" blamer-show-posframe-commit-info "Bramer")
    ("m" magit-status                     "Magit"))

   "View"
   (("D" delete-other-windows      "Only This Win")
    ("W" window-control-hydra/body "Window Control")
    ("+" text-scale-hydra/body     "Text Scale")
    ("w" ace-swap-window           "Swap Window"))

   "Tool"
   (("SPC" major-mode-hydra         "Hydra(Major)")
    ("s"   toggle-hydra/body        "Toggle switches")
    ("c"   counsel-org-capture      "Capture")
    ("o"   global-org-hydra/body    "Org")
    ("e"   el-get-hydra/body        "el-get")
    ("k"   kibela-hydra/body        "Kibela")
    ("/"   google-pretty-hydra/body "Google")
    ("t"   subtools-hydra/body      "Sub Tools"))))
```

| Key | 効果                                                                       |
|-----|--------------------------------------------------------------------------|
| p   | [Projectile]({{< relref "projectile" >}}) 用の Hydra 起動                  |
| f   | counsel でファイルを開く                                                   |
| d   | counsel でフォルダ開く                                                     |
| r   | counsel で最近使ったファイルを開く                                         |
| l   | counsel で locate する。Mac だと mdfind だけど                             |
| A   | counsel で macOS の Application を開く                                     |
| a   | 正規表現に基いて整形                                                       |
| ;   | コメント挿入。 M-; を使ってるから要らないかも                              |
| G   | projectile 内の検索。関係ないのがかかる時もあるので調整必要                |
| j   | [dumb-jump]({{< relref "dumb-jump" >}}) 用の Hydra 起動                    |
| g   | 画面上の好きな位置にジャンプする [avy]({{< relref "avy" >}}) の起動        |
| i   | counsel-imenu 起動。使ってない気がする                                     |
| y   | [yasnippet]({{< relref "yasnippet" >}}) 用の Hydra 起動                    |
| B   | [browse-at-remote]({{< relref "browse-at-remote" >}}) で GitHub などのコード位置を開く |
| m   | [magit]({{< relref "magit" >}}) を起動                                     |
| D   | 他の Window を消す                                                         |
| W   | フレームサイズや位置を弄るための Hydra を起動。ほぼ使ってない              |
| +   | [文字サイズ変更用 Hydra](#text-scale) の起動                               |
| w   | Window の入替                                                              |
| SPC | [major-mode-hydra](https://github.com/jerrypnz/major-mode-hydra.el) の起動 |
| s   | [ON/OFF 切替系の Hydra](#toggle-switches) を起動する                       |
| c   | counsel-org-capture を呼び出す                                             |
| o   | org-mode 用の Hydra を起動する                                             |
| e   | el-get 用の Hydra を起動する                                               |
| t   | [第一階層には入れてないけどまあまあ便利なコマンドを詰めた Hydra](#sub-tools) を起動する |
