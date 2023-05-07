+++
title = "forge"
draft = false
+++

## 概要 {#概要}

[forge](https://github.com/magit/forge) は magit と github を連携させるやつ。一応入れているけど実は使えてないのであまりこの設定を呼んでも意味はなさそう


## インストール {#インストール}

いつも通り el-get でインストールする。ただし依存関係で必要なので emacs-sqlite3-api も合わせて入れている

```emacs-lisp
(el-get-bundle emacs-sqlite3-api)
(el-get-bundle forge)
```


## 読み込み {#読み込み}

magit の拡張なので magit を読み込んで後に読み込まれるようにしている。依存で必要な sqlite3 も合わせて require している。

```emacs-lisp
(with-eval-after-load 'magit
  (require 'sqlite3)
  (require 'forge))
```


## flycheck の有効化 {#flycheck-の有効化}

Pull Request を作る時に text-lint で指摘されたいのでそのタイミングで flycheck を有効化している

```emacs-lisp
(defun my/forge-post-mode-hook ()
  (flycheck-mode 1))

(with-eval-after-load 'forge
  (add-hook 'forge-post-mode-hook 'my/forge-post-mode-hook))
```


## その他 {#その他}

リポジトリのコミット数が多いとまともに使えない感じだけどどうしたらいいの。
