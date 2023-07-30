+++
title = "emacs-lisp"
draft = false
+++

## 概要 {#概要}

Emacs Lisp を書くための設定。まあそんなにしっかり書いてないので、あんまり設定は入ってない


## Hook {#hook}

Hook 用の関数を定義してその中に色々書いている。

-   とりあえず行数表示が欲しいので display-line-numbers-mode を有効化
-   当然補完もしたいので company-mode を有効にしている
-   カッコの対応などもいい感じに動いて欲しいので smartparens-mode とその strict-mode を有効にしている

<!--listend-->

```emacs-lisp
(defun my/emacs-lisp-mode-hook ()
  (display-line-numbers-mode 1)
  (origami-mode 1)
  (company-mode 1)
  (smartparens-mode 1)
  (turn-on-smartparens-strict-mode))
```

そんで最後にその関数を hook に突っ込んでる。

```emacs-lisp
(add-hook 'emacs-lisp-mode-hook 'my/emacs-lisp-mode-hook)
```


## アイコン挿入コマンドの用意 {#アイコン挿入コマンドの用意}

時々 UI 設定目的で絵文字を使うことがあるので挿入できるコマンドを用意している。最近使った記憶ないけど。

```emacs-lisp
(defun my/insert-all-the-icons-code (family)
  (interactive)
  (let* ((candidates (all-the-icons--read-candidates-for-family family))
         (prompt     (format "%s Icon: " (funcall (all-the-icons--family-name family))))
         (selection  (completing-read prompt candidates nil t)))
    (insert "(all-the-icons-" (symbol-name family) " \"" selection "\")")))
```


## キーバインド {#キーバインド}

emacs-lisp-mode 用に major-mode-hydra を設定している。けどそんなにしっかり Emacs Lisp を書いてるわけではないのがバレバレな感じである。

```emacs-lisp
(with-eval-after-load 'major-mode-hydra
  (major-mode-hydra-define emacs-lisp-mode (:separator "-" :quit-key "q" :title (concat (all-the-icons-fileicon "elisp") " Emacs Lisp"))
    ("Describe"
     (("F" counsel-describe-function "Function")
      ("V" counsel-describe-variable "Variable"))

     "Insert Icon Code"
     (("@a" (my/insert-all-the-icons-code 'alltheicon) "All the icons")
      ("@f" (my/insert-all-the-icons-code 'fileicon)   "File icons")
      ("@F" (my/insert-all-the-icons-code 'faicon)     "FontAwesome")
      ("@m" (my/insert-all-the-icons-code 'material)   "Material")
      ("@o" (my/insert-all-the-icons-code 'octicon)    "Octicon")
      ("@w" (my/insert-all-the-icons-code 'wicon)      "Weather")))))
```

| Key | 効果                    |
|-----|-----------------------|
| F   | 関数を調べる            |
| V   | 変数を調べる            |
| @a  | all-the-icon のアイコンを挿入 |
| @f  | fileicon のアイコンを挿入 |
| @F  | FontAwesome のアイコンを挿入 |
| @m  | Material Icons のアイコンを挿入 |
| @o  | Octicons のアイコンを挿入 |
| @w  | 天気アイコンを挿入      |
