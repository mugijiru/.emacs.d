+++
title = "scss"
draft = false
+++

## 概要 {#概要}

scss を使う上での設定をここではまとめている。長いこと手を入れてないので今はより良い設定がありそうな気がする。


## rainbow-mode {#rainbow-mode}

[rainbow-mode](https://elpa.gnu.org/packages/rainbow-mode.html) はカラーコードを入力した際に、そのカラーコード部分の背景色をカラーコードの色に変化させるパッケージ。ぱっと見で大体どんな色かわかって便利なやつ


### インストール {#インストール}

自分はel-get で入れている。

```emacs-lisp
(el-get-bundle rainbow-mode)
```

ELPA に登録されているので package-install でもいける


## scss-mode {#scss-mode}

scss-mode は Emacs 組込みの css-mode の中で定義されているメジャーモード。なのでインストール不要で使えるし
`.scss` という拡張子なら自動的に scss-mode で開いてくれるようになっている。


### 設定 <span class="tag"><span class="improvement">improvement</span></span> {#設定}

インデントはデフォルトだと半角空白 4 つとなっているが麦汁さん的には 2 の方が良いのでそのように変更している。

```emacs-lisp
(with-eval-after-load 'scss-mode
  (setq css-indent-offset 2))
```

`with-eval-after-load` を使っているが
`css-indent-offset` は `defcustom` で定義されているので
`custom-set-variables` を使うように修正した方が良さそう


## flycheck の scss-stylelint を上書き {#flycheck-の-scss-stylelint-を上書き}

stylelint v14 以降は --style オプションが使えないので上書き
<https://github.com/flycheck/flycheck/pull/1944> が取り込まれたらこれも要らなさそうだけど。

```emacs-lisp
(with-eval-after-load 'flycheck
  (flycheck-define-checker scss-stylelint
    "A SCSS syntax and style checker using stylelint.

See URL `http://stylelint.io/'."
    :command ("stylelint"
              (eval flycheck-stylelint-args)
              (option-flag "--quiet" flycheck-stylelint-quiet)
              (config-file "--config" flycheck-stylelintrc))
    :standard-input t
    :error-parser flycheck-parse-stylelint
    :predicate flycheck-buffer-nonempty-p
    :modes (scss-mode)))
```


## hook <span class="tag"><span class="improvement">improvement</span></span> {#hook}

scss を使う上で hook を使って色々有効化したりしている。

```emacs-lisp
(defun my/scss-mode-hook ()
  (flycheck-mode 1)

  (setq-local lsp-prefer-flymake nil)
  (lsp)
  (lsp-ui-mode -1)

  (smartparens-strict-mode 1)

  ;; lsp-ui とかより後に設定しないと上書きされるのでここに移動した
  (setq-local flycheck-checker 'scss-stylelint)
  (setq-local flycheck-check-syntax-automatically '(save new-line idle-change))

  (company-mode 1)
  (display-line-numbers-mode 1)

  (rainbow-mode))
(add-hook 'scss-mode-hook 'my/scss-mode-hook)
```

-   flycheck-mode の有効化
    -   これによりリアルタイムに lint 結果が分かって便利になる
-   lsp-prefer-flymake の無効化
    -   flycheck が有効にならない問題を防いでいる。どうも自分の設定の書き方が悪い気もするが……。
-   lsp-mode を有効化しつつ lsp-ui は無効にしている
    -   lsp-ui が有効だと画面上でガチャガチャ height とかのプロパティの説明をしてうざいので
-   smartparens-strict-mode を入れることで {} のペアが維持されるようにしている
-   flycheck-checker, flycheck-check-syntax-automatically の設定
    -   lsp-ui とかより後に設定しないと上書きされるので、それらより後に設定している
    -   設定の書き方の悪さのせいな気もする
-   company-mode の有効化。これがないと補完できなくて厳しいよね
-   display-line-numbers-mode の有効化。行数表示も欲しいよね。巨大ファイルだと邪魔だけど巨大にしなきゃいい
-   [rainbow-mode](#rainbow-mode) の有効化


## カラーコード→ CSS Variable の置き換え {#カラーコード-css-variable-の置き換え}

外部コマンドで fetch-color-var というのを定義してそいつにカラーコードを渡すとプロジェクトで使ってる CSS Variable を返してくるようにしている。

で、それを Emacs から叩いて使えるようにしているのが以下のコマンド

```emacs-lisp
(defun my/replace-var (point mark)
  (interactive "r")
  (let* ((str (buffer-substring point mark))
         (cmd (concat "fetch-color-var '" str "'"))
         (response (shell-command-to-string cmd)))
    (delete-region point mark)
    (insert response)))
```


## キーバインド {#キーバインド}

設定しているけど使ってないなあ……。

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define scss-mode (:quit-key "q" :title (concat (all-the-icons-alltheicon "css3") " CSS"))
    ("Edit"
     (("v" my/replace-var "replace-var")))))
```

| Key | 効果                                      |
|-----|-----------------------------------------|
| v   | リージョンの値で CSS 変数を検索して置き換えるやつ。自作コマンドを利用している |
