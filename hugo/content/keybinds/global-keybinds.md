+++
title = "グローバルキーバインド"
draft = false
+++

## 概要 {#概要}

Emacs では様々なグローバルマイナーモードが存在したりしていていつでも使えるようなコマンドが多数存在するのでここでまとめて定義している。

が、Hydra 関係もここに書くと項目が大きくなりすぎるので、それはまた別途定義している。


## Mac での修飾キー変更 {#mac-での修飾キー変更}

```emacs-lisp
(if (eq window-system 'ns)
    (progn
      (setq ns-alternate-modifier (quote super)) ;; option  => super
      (setq ns-command-modifier (quote meta))))  ;; command => meta
```


## C-h を backspace に変更 {#c-h-を-backspace-に変更}

C-h で文字を消せないと不便なのでずっと昔からこの設定は入れている。

```emacs-lisp
(keyboard-translate ?\C-h ?\C-?)
(global-set-key "\C-h" nil)
```


## M-g rをstring-replaceに割り当て {#m-g-rをstring-replaceに割り当て}

string-replace はよく使うのでそれなりに使いやすいキーにアサインしている

```emacs-lisp
(global-set-key (kbd "M-g r") 'replace-string)
```

replace-regexp もまあまあ使うけどそれはキーを当ててないのでどこかでなんとかしたい。
Hydra 使う?


## C-\\ で SKK が有効になるようにする {#c-で-skk-が有効になるようにする}

C-\\ で skk-mode を起動できるようにしている。
C-x C-j の方も設定は生きているが使ってない。っていうか忘れてた。

```emacs-lisp
(global-set-key (kbd "C-\\") 'skk-mode)
```

余談だけど org-mode とか commit message 書く時とかは自動で有効になるようにしたい気はする。


## C-s を swiper に置き換え {#c-s-を-swiper-に置き換え}

デフォルトだと C-s でインクリメンタルサーチが起動するが
swiper の方が絞り込みができて便利だしカッチョいいのでそっちを使うようにしている

```emacs-lisp
(global-set-key (kbd "C-s") 'swiper)
```


## window 間の移動 {#window-間の移動}


### C-x o を ace-window に置き換え {#c-x-o-を-ace-window-に置き換え}

C-x o はデフォルトだと順番に window を移動するコマンドだが
ace-window を使えばたくさん画面分割している時の移動が楽だし
2分割の時は元の挙動と同様に2つの window を行き来する感じになので完全に置き換えても大丈夫と判断して、置き換えている。

```emacs-lisp
(global-set-key (kbd "C-x o") 'ace-window)
```

ace-window は他にもコマンドがあって
Hydra の方で ace-swap-window は使えるようにしている


### Shift+カーソルキーで window 移動 {#shift-plus-カーソルキーで-window-移動}

シフトキーを押しながらカーソルキーを押すことでも
window を移動できるようにしている

```emacs-lisp
(windmove-default-keybindings)
```

ただし org-mode のキーバインドとぶつかるので実はあまり使ってないしそろそろ無効にしてもいいんじゃないかなという気もしている


## undo/redo {#undo-redo}

undo  と redo には undo-fu を使っている

```emacs-lisp
(global-set-key (kbd "C-/") 'undo-fu-only-undo)
(global-set-key (kbd "C-M-/") 'undo-fu-only-redo)
```


## \\ を入力した時に円マークにならないようにする設定 {#を入力した時に円マークにならないようにする設定}

Mac だとデフォルト状態だと \\ を入れると円マークになるのだがプログラムを書く上ではバックスラッシュであってほしいので円マークが入力された時はバックスラッシュが入力されたように扱われるようにしている。

```emacs-lisp
(define-key global-map [?¥] [?\\])
(define-key global-map [?\C-¥] [?\C-\\])
(define-key global-map [?\M-¥] [?\M-\\])
(define-key global-map [?\C-\M-¥] [?\C-\M-\\])
```

ただ、たまに円マークを出したくなる時があるのでその時はどうすべきかという課題がある。


## multiple-cursors {#multiple-cursors}

カーソルを複数表示できる [multiple-cursors](https://github.com/magnars/multiple-cursors.el) 用のキーバインド。基本的には公式 README に従って設定している。

```emacs-lisp
;; multiple-cursors
(global-set-key (kbd "C-:") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
```

Ladicle さんの <https://ladicle.com/post/config/#multiple-cursor> の設定が便利そうだなって思って気になってるけどまだ試してない。


## Ivy {#ivy}

Helm から乗り換えて今はこちらをメインで使っている。基本的には既存のキーバインドの持っていた機能が強化されるようなコマンドを代わりに割り当てている。デフォルトより良い感じで良い。

```emacs-lisp
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
```

| Key     | 効果                                                           |
|---------|--------------------------------------------------------------|
| M-x     | コマンド実行。絞り込みができるのでコマンド名がうろ覚えでも実行できて便利 |
| M-y     | kill-ring の候補表示。適当に複数 kill-ring に入れておいてこれを起動して絞り込んで貼り付けとかできて便利 |
| C-x b   | バッファ切替。これも適当にバッファを絞り込めて便利             |
| C-x C-f | find-file の置き換え。ido より便利な感じの絞り込み選択ができる。 |


## zoom-window <span class="tag"><span class="unused">unused</span></span> {#zoom-window}

[zoom-window](https://github.com/emacsorphanage/zoom-window) は tmux の zoom 機能のように選択している window だけを表示したり戻したりができるパッケージ。

```emacs-lisp
(global-set-key (kbd "C-x 1") 'zoom-window-zoom)
```

実は戻すことがあんまりないので、このキーバインドは戻してもいいかもしれないなと思っていたりする。


## neotree <span class="tag"><span class="unused">unused</span></span> {#neotree}

Neotree]] は IDE みたいにファイルツリーを表示を表示するパッケージ。有効にしているとちょっぴりモダンな雰囲気になるぞい。

```emacs-lisp
(global-set-key [f8] 'neotree-toggle)
```

f8 にバインドしているけど
Helm でも起動できるようにしているので、こっちの設定は外してもいいかもなとか思っている。


## org-mode <span class="tag"><span class="unused">unused</span></span> {#org-mode}

みんな大好き org-mode 用にもキーバインドを設定している。

```emacs-lisp
(setq my/org-mode-prefix-key "C-c o ")
(global-set-key (kbd (concat my/org-mode-prefix-key "a")) 'org-agenda)
(global-set-key (kbd (concat my/org-mode-prefix-key "c")) 'org-capture)
(global-set-key (kbd (concat my/org-mode-prefix-key "l")) 'org-store-link)
```

けど org-mode 用の Hydra も用意しているのでこれもそろそろ削除かな……


## keychord {#keychord}

keycohrd は2つのキーを同時押しというキーバインドを実現するパッケージ。

とりあえず jk を入力するとグローバルに使いたいコマンドを載せた Hydra が起動するようにしている。めっちゃ使ってる。便利。

```emacs-lisp
(key-chord-define-global "jk" 'pretty-hydra-usefull-commands/body)
```


## yes or no ではなく y or n で質問する {#yes-or-no-ではなく-y-or-n-で質問する}

何か質問された時に yes とか入力するのがだるいので
y だけで済ませられるようにしている。

```emacs-lisp
;; Don't ask yes or no.
(defalias 'yes-or-no-p 'y-or-n-p)
```

一応 Emacs 的には重要なのは yes/no で回答するようになっていたはずなのでより安全に使いたい人はこの設定は入れない方が良いはず。
