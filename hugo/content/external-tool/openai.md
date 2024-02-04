+++
title = "openai"
draft = false
+++

## 概要 {#概要}

[OpenAI.el](https://github.com/emacs-openai/openai) は OpenAI などの API を使うための Emacs Lisp ライブラリ。直接使うよりは、これを使ったアプリを開発するために使うものなのかなと思う。

最近は特に使ってないけどとりあえず設定ファイルがあるのでドキュメントにも反映しておく


## インストール {#インストール}

例によってレシピは el-get 本体にはなので自前で用意

```emacs-lisp
(:name emacs-openai
       :website "https://github.com/emacs-openai/openai"
       :description "Elisp library for the OpenAI API."
       :type github
       :branch "master"
       :pkgname "emacs-openai/openai"
       :depends (request tblui))
```

依存している `tblui` も el-get 本体にはレシピがないのでこれも自前で用意

```emacs-lisp
(:name tblui
       :website "https://github.com/Yuki-Inoue/tblui.el"
       :description "Define tabulated-list based UI easily."
       :type github
       :branch "master"
       :pkgname "Yuki-Inoue/tblui.el"
       :depends (dash magit-popup tablist))
```

そして `el-get-bundle` でインストール

```emacs-lisp
(el-get-bundle emacs-openai)
```


## API キーなどの設定 {#api-キーなどの設定}

authinfo で管理してそこから読み取るよういしている

```emacs-lisp
(setq openai-user (plist-get (nth 0 (auth-source-search :host "api.openai.com")) :user))
(setq openai-key (funcall (plist-get (nth 0 (auth-source-search :host "api.openai.com")) :secret)))
```


## その他 {#その他}

今は使ってないので説明は雑に。

API 叩いて質問ができるようにしたり、補完して続きを適当に書いてもらったりするような関数を定義している。どこかのものを参考にしたはずだけど覚えてないな……

```emacs-lisp
(defvar-local my/openai-result nil)

(defun my/openai-completion-from-prompt (input)
  (interactive "sText: ")
  (openai-completion input
                     (lambda (data)
                       (let* ((choices (openai--data-choices data))
                              (result (openai--get-choice choices)))
                         (message "result: %s" result))) :max-tokens 2000))

(defun my/openai-observe (buf end)
  (cond
   (my/openai-result
    (save-current-buffer
      (set-buffer (get-buffer buf))
      (goto-char end)
      (insert my/openai-result)
      (setq my/openai-result nil)
      (my/openai-stop-observe)))
   (t
    nil)))

(defvar my/openai-observe-timer nil)

(defun my/openai-start-observe (buf end)
  (setq my/openai-observe-timer
        (run-with-idle-timer 0.5 t 'my/openai-observe buf end)))

(defun my/openai-stop-observe ()
  (cancel-timer my/openai-observe-timer))

(defun my/openai-completion-from-region (begin end)
  (interactive "r")
  (my/openai-start-observe (current-buffer) end)
  (openai-completion (buffer-substring-no-properties begin end)
                     (lambda (data)
                       (let* ((choices (openai--data-choices data))
                              (result (openai--get-choice choices)))
                         (setq my/openai-result result)))
                     :max-tokens 4000)
  (deactivate-mark t))
```
