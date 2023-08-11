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
