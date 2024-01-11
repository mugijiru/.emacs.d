+++
title = "copilot"
draft = false
+++

## 概要 {#概要}

[Copilot.el](https://github.com/zerolfx/copilot.el) は [GitHub Copilot](https://github.com/features/copilot) を Emacs で使えるようにするパッケージ。これ自体は非公式なプラグインで、動かすために Vim で動く公式プラグインのバイナリを利用して動いている


## インストール {#インストール}

最近出て来たパッケージなので el-get には登録されていない。というわけでとりあえず自前でレシピを用意している

```emacs-lisp
(:name copilot
       :website "https://github.com/zerolfx/copilot.el"
       :description "An Emacs plugin for GitHub Copilot."
       :type github
       :branch "main"
       :pkgname "zerolfx/copilot.el"
       :depends (s dash editorconfig jsonrpc))
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle copilot)
```


## 設定 {#設定}

とりあえずプログラミング系の mode で有効になるようにしている

```emacs-lisp
(add-hook 'prog-mode-hook 'copilot-mode)
```

なのだけどそのままだと enh-ruby-mode では有効にならないので
`copilot-major-mode-alist` に突っ込んでいる。なおこの設定は [公式の README にも書かれている](https://github.com/zerolfx/copilot.el#programming-language-detection)

```emacs-lisp
(with-eval-after-load 'copilot
  (add-to-list 'copilot-major-mode-alist '("enh-ruby" . "ruby")))
```

あと何故か忘れたけど inline preview を無効にするような設定を入れている

```emacs-lisp
(with-eval-after-load 'company
  ;; disable inline previews
  (delq 'company-preview-if-just-one-frontend company-frontends))
```


## キーバインド {#キーバインド}

タブで補完ができるように設定している

```emacs-lisp
(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion))
```
