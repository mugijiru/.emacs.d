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

他にも mode-line の表示が不要なモードとかってありそうだけど特に思い付かないから今のところ Neotree 専用になっている。


## 日時を mode-line で表示する {#日時を-mode-line-で表示する}

mode-line に日時も表示されてる方が便利な気がしてとりあえず表示している。

```emacs-lisp
(display-time-mode 1)
```


## smart-mode-line 関連の設定 {#smart-mode-line-関連の設定}

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
;; (my/diminish "helm" 'helm-mode ":helmet-with-cross:")
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


## その他 {#その他}

バッテリー残量表示とかもしているけどそのあたりの設定どこでやってんだっけ?
