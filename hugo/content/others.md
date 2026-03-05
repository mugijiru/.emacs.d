+++
title = "その他"
draft = false
+++

## ファイルパスをコピーするコマンド {#ファイルパスをコピーするコマンド}

単にファイルパスをコピーしたい時があるので
適当にそういうコマンドを用意している

```emacs-lisp
(defun my/copy-file-path ()
  "Copy the current buffer file path to the clipboard."
  (interactive)
    (when buffer-file-name
      (kill-new buffer-file-name)
      (message "Copied buffer file path '%s' to the clipboard." buffer-file-name)))
```


## Wayland + pgtk Emacs のクリップボード連携バグの回避策 {#wayland-plus-pgtk-emacs-のクリップボード連携バグの回避策}

どうやら Wayland + pgtk Emacs だとクリップボード取得周りに不具合があるみたい。
それを回避するために `interprogram-cut-function` と `interprogram-cut-function` を書き換えている。

```emacs-lisp
(setq interprogram-cut-function
      (lambda (text &optional push)
        (let ((process-connection-type nil))
          (call-process-region text nil "wl-copy"))))

(setq interprogram-paste-function
      (lambda ()
        (shell-command-to-string "wl-paste -n")))
```

Emacs 30.2 に上げたら発生するようになった気がするので 30.3 になったら一度外してみようと思う
