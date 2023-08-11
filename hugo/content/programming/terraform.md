+++
title = "Terraform"
draft = false
+++

## 概要 {#概要}

[Terraform](https://www.terraform.io/) はオープンソースの IaC ツール。結構よく使われている。色々なクランドサービスに対応していて便利。


## terraform-mode {#terraform-mode}

[terraform-mode](https://github.com/hcl-emacs/terraform-mode) は Emacs で terraform のコードを書くための major-mode を提供してくれるやつ。


### インストール {#インストール}

el-get にも terraform-mode のレシピはあるけど
dash の依存が書かれていないのでとりあえず自前で用意している

```emacs-lisp
(:name terraform-mode
       :type github
       :pkgname "emacsorphanage/terraform-mode"
       :description "Major mode for Terraform configuration files"
       :depends (hcl-mode dash))
```

そしてそれを `el-get-bundle` で入れている

```emacs-lisp
(el-get-bundle terraform-mode)
```


### 設定 {#設定}

保存時に自動で整形してほしいのでその設定を入れている

```emacs-lisp
(custom-set-variables
 '(terraform-format-on-save t))
```


### hooks {#hooks}

hook を使っていくつかの minor-mode を有効にしている

origami
: コードの折り畳み

company
: コード補完

smartparens-strict-mode
: カッコの対応を強力にしてくれるやつ

display-line-numbers-mode
: 行数表示

:ID:       dc0abe68-1440-4519-9b27-01856ebca176

```emacs-lisp
(defun my/terraform-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'terraform-mode-hook 'my/terraform-mode-hook)
```
