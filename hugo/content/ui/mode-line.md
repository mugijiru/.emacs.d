+++
title = "mode-line"
draft = false
+++

## 概要 {#概要}

Emacs のバッファ下部に表示されるモードライン関連の設定をここにまとめている。このメニューの並びとかはどこかで直した方が良さそう。


## hide-mode-line {#hide-mode-line}

[hide-mode-line](https://github.com/hlissner/emacs-hide-mode-line) は mode-line を隠してくれるパッケージ。ここでは neotree-mode-hook で引っ掛けて Neotree では mode-line を隠すように設定している

```emacs-lisp
(el-get-bundle hlissner/emacs-hide-mode-line)
(add-hook 'neotree-mode-hook #'hide-mode-line-mode)
```

レシピは自前で用意している

```emacs-lisp
(:name emacs-hide-mode-line
  :type github
  :description "minor mode that hides/masks your modeline."
  :pkgname "hlissner/emacs-hide-mode-line"
  :minimum-emacs-version (24 4))
```

他にも mode-line の表示が不要なモードとかってありそうだけど特に思い付かないから今のところ Neotree 専用になっている。


## 日時を mode-line では表示しない {#日時を-mode-line-では表示しない}

今だと i3bar に時計が表示されていていつもそれを見るので
mode-line の日時表示は要らないな〜と思ったので非表示にした

```emacs-lisp
(custom-set-variables '(display-time-24hr-format t))
(display-time-mode -1)
```

表示していたころの名残りで時計の表示形式は24時間表記の設定。表示する場合、「午前」とか「午後」とかの表示邪魔だしね。


## smart-mode-line 関連の設定 <span class="tag"><span class="unused">unused</span></span> {#smart-mode-line-関連の設定}

[smart-mode-line](https://github.com/Malabarba/smart-mode-line) は mode-line をセクシーな感じにしてくれるパッケージ。というわけで昔入れていたけどもう使ってない。一応コードの残骸があったから一旦残しておく。

多分アイコン表示周りをゴリゴリ設定するのがだるくなって doom-modeline に乗り換えたんだと思う。

```emacs-lisp
;; (el-get-bundle smart-mode-line)
;; (defvar sml/no-confirm-load-theme t)
;; (defvar sml/theme 'dark)
;; (sml/setup)

;; major-mode
;; (add-hook 'emacs-lisp-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "elisp"))))
;; (add-hook 'enh-ruby-mode-hook (lambda () (setq mode-name (concat "e" (all-the-icons-alltheicon "ruby-alt")))))
;; (add-hook 'ruby-mode-hook (lambda () (setq mode-name (all-the-icons-alltheicon "ruby-alt"))))
;; (add-hook 'vue-mode-hook (lambda ()
;;                            (make-local-variable 'mmm-submode-mode-line-format)
;;                            (setq mmm-submode-mode-line-format "~M:~m")
;;                            (make-local-variable 'mmm-buffer-mode-display-name)
;;                            (setq mmm-buffer-mode-display-name "V")))
;; (add-hook 'js-mode-hook (lambda () (setq mode-name "")))
;; (add-hook 'pug-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "pug"))))
;; (add-hook 'css-mode-hook (lambda () (setq mode-name (all-the-icons-faicon "css3"))))
;; (add-hook 'twittering-mode-hook (lambda () (setq mode-name (all-the-icons-faicon "twitter-square"))))
;; (add-hook 'org-mode-hook (lambda () (setq mode-name (all-the-icons-fileicon "org"))))
```


## diminish {#diminish}

[diminish](https://github.com/emacsmirror/diminish) は minor-mode の表示をカスタマイズするためのモード。

これも昔使ってたけど今は使ってない。というか最近はマイナーモードを mode-line で表示してない。表示しなくなったから要らなくなった感じ。


### インストール・有効化 {#インストール-有効化}

el-get-bundle で入れて require したら有効になる

```emacs-lisp
(el-get-bundle diminish)
(require 'diminish)
```


### マクロ定義 {#マクロ定義}

各パッケージが読まれた後に指定した表示が設定されるようにするマクロを書いている。

```emacs-lisp
(defmacro my/diminish (file mode &optional new-name)
  "https://github.com/larstvei/dot-emacs/blob/master/init.org"
  `(with-eval-after-load ,file
     (diminish ,mode ,new-name)))
```

<https://github.com/larstvei/dot-emacs/blob/master/init.org>
に書かれているのを流用しただけであるはずだが、リンク先にその記述が見当たらないな……。


### マイナーモード毎の表示指定 {#マイナーモード毎の表示指定}

上で用意したマクロを用いて各マイナーモード毎の設定を行っていた。今は使ってないので全部コメントアウトしている

```emacs-lisp
;; (my/diminish "git-gutter" 'git-gutter-mode (all-the-icons-octicon "git-compare"))
;; (my/diminish "yasnippet" 'yas-minor-mode " Ys")
;; (my/diminish "whitespace" 'whitespace-mode "◽")
;; (my/diminish "whitespace" 'global-whitespace-mode "◽")
;; (my/diminish "tempbuf" 'tempbuf-mode "")
;; (my/diminish "flycheck" 'flycheck-mode "")
;; (my/diminish "zoom" 'zoom-mode "")
;; (my/diminish "rainbow" 'rainbow-mode "🌈")
;; (my/diminish "projectile-rails" 'projectile-rails-mode "🛤")
;; (my/diminish "company" 'company-mode "")
;; (my/diminish "ElDoc" 'eldoc-mode "")
```

結構頑張ったけど絵文字周りで思うような表示にならなかったりして最終的にはマイナーモードを mode-line に表示しないようになっている。

使ってる minor-mode どうやって把握したりしたらいいんだろうね。ま、表示されなくてもなんとなくで把握しているから、困ってはいないんだけど。


## doom-modeline {#doom-modeline}

[doom-modeline](https://github.com/seagle0128/doom-modeline) は Emacs の mode-line を装飾するパッケージの1つ。結構スッキリした見た目になるので気に入ってる。


### インストール {#インストール}

el-get のレシピは自前で用意している

```emacs-lisp
(:name doom-modeline
       :website "https://github.com/seagle0128/doom-modeline"
       :description "A fancy and fast mode-line which was from DOOM Emacs, but it's more powerful and much faster."
       :depends (shrink-path compat)
       :type github
       :pkgname "seagle0128/doom-modeline")
```

依存している shrink-path も自前でレシピを用意している

```emacs-lisp
(:name shrink-path
       :website "https://gitlab.com/bennya/shrink-path.el"
       :description "Small utility functions that allow for fish-style trunctated directories in eshell and for example modeline."
       :depends (dash f s)
       :type git
       :url "https://gitlab.com/bennya/shrink-path.el.git")
```

そして以下でインストール

```emacs-lisp
(el-get-bundle doom-modeline)
```


### 有効化 {#有効化}

```emacs-lisp
(doom-modeline-mode 1)
```


### VCS 用表示の長さ変更 {#vcs-用表示の長さ変更}

デフォルトだと 12 なんだけどそれだと短かくて何のブランチかよくわからんので
30 まえのばしている。

```emacs-lisp
(setq doom-modeline-vcs-max-length 30)
```


### バッテリー残量表示 {#バッテリー残量表示}

これは doom-modeline 専用の設定ではないけど
doom-modeline で見た目をカッコよくしているのでこっちに設定を書いている。

```emacs-lisp
(display-battery-mode 1)
```


### その他 {#その他}

`doom-modeline-github` を t にしたら GitHub の通知数も表示されるらしいがちょっと試しに t にしているけどどうも表示されない。

あとはメジャーモード名はアイコンの方があるから消したいな。
`doom-modeline-def-modeline` で自分用に作れば良さそうな雰囲気はある


## その他 {#その他}

多分 mode-line 周りはもうちょっと整理した方が設定は読み易いんだろうなという気がしている
