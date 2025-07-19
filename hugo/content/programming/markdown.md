+++
title = "markdown"
draft = false
+++

## 概要 {#概要}

Markdown を書くための設定。といいつつ markdown-mode を入れてるだけだけども。

手元でテキストドキュメントを弄るのは org-mode が多いからなあ……


## インストール {#インストール}

いつも通り el-get で入れている。

```emacs-lisp
(el-get-bundle markdown-mode)
```


## 設定 {#設定}

今のところは行番号が表示されるようにしているだけ

```emacs-lisp
(defun my/markdown-mode-hook()
  (display-line-numbers-mode 1))

(add-hook 'markdown-mode-hook 'my/markdown-mode-hook)
```
