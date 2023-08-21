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

flyccheck
: コードの変な部分の指摘

smartparens-strict-mode
: カッコの対応を強力にしてくれるやつ

display-line-numbers-mode
: 行数表示

flycheck に関しては [terraform-tflint が tflint 0.47 に対応してない](https://github.com/flycheck/flycheck/issues/2024)のでそいつだけ無効にしている

```emacs-lisp
(defun my/terraform-mode-hook ()
  (origami-mode 1)
  (company-mode 1)
  (setq-local flycheck-checker 'terraform)
  (setq-local flycheck-disabled-checkers '(terraform-tflint))
  (flycheck-mode 1)
  (turn-on-smartparens-strict-mode)
  (display-line-numbers-mode 1))

(add-hook 'terraform-mode-hook 'my/terraform-mode-hook)
```
