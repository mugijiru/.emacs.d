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
       :website "https://github.com/copilot-emacs/copilot.el"
       :description "An Emacs plugin for GitHub Copilot."
       :type github
       :branch "main"
       :pkgname "copilot-emacs/copilot.el"
       :depends (s dash editorconfig jsonrpc))
```

依存している editorconig も自前でレシピを用意している

```emacs-lisp
(:name editorconfig
       :website "https://github.com/editorconfig/editorconfig-emacs"
       :description "An EditorConfig plugin for Emacs."
       :type github
       :branch "master"
       :pkgname "editorconfig/editorconfig-emacs")
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle copilot)
```


## 設定 {#設定}

とりあえずプログラミング系の mode で有効になるようにしていた。けど今はちょっと無効にしている

```emacs-lisp
;; (add-hook 'prog-mode-hook 'copilot-mode)
```

あとは company-mode と組み合わせてもそれなりに動くようにするため
inline preview を無効にするような設定を入れている。なおこの設定は[公式の README の中のコード](https://github.com/copilot-emacs/copilot.el#example-for-spacemacs)を使っている

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
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "M-f") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "M-n") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "M-p") 'copilot-previous-completion))
```


## warning 非表示 {#warning-非表示}

大きいファイルが開かれると

```text
Warning (copilot): .loaddefs.el size exceeds 'copilot-max-char' (100000), copilot completions may not work
```

とか出るけど、そんなもんは分かってるので warning が出ないように黙らせている

```emacs-lisp
(setopt copilot-max-char-warning-disable t)
```

またデフォルトだと indent offset は設定が見つからない時に warning を出すようになっているが結構邪魔なのでとりあえずオフにしている

```emacs-lisp
(setopt copilot-indent-offset-warning-disable t)
```
