+++
title = "その他"
draft = false
+++

## ファイルパスをコピーするコマンド {#ファイルパスをコピーするコマンド}

単にファイルパスをコピーしたい時があるので適当にそういうコマンドを用意している

```emacs-lisp
(defun my/copy-file-path ()
  "Copy the current buffer file path to the clipboard."
  (interactive)
    (when buffer-file-name
      (kill-new buffer-file-name)
      (message "Copied buffer file path '%s' to the clipboard." buffer-file-name)))
```
