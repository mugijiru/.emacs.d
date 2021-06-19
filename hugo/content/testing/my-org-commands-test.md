+++
title = "my-org-commands-test"
draft = false
weight = 3
+++

org-mode 用に定義したコマンドや関数のテストコード


## Setup {#setup}


### テストライブラリの読み込み {#テストライブラリの読み込み}

標準でついてくる ert を採用しているのでそれを読み込んでいる。

```emacs-lisp
(require 'ert)
```


### el-get の設定の読み込み {#el-get-の設定の読み込み}

プラグイン管理には el-get を利用しているのでその設定ファイルを読み込んでいる。

```emacs-lisp
;; プラグイン読み込みの前準備
(load (expand-file-name (concat user-emacs-directory "/init-el-get.el")))
```


### テスト補助のプラグイン読み込み {#テスト補助のプラグイン読み込み}


#### with-simulated-input {#with-simulated-input}

上で説明しているが、入力をシミュレートするためのプラグインをテストで利用しているのでここで読み込んでいる。

```emacs-lisp
;; 入力シミュレート用のプラグイン
(load (expand-file-name (concat user-emacs-directory "/inits/99-with-simulated-input")))
```


### 依存プラグインの読み込み {#依存プラグインの読み込み}

テスト対象が依存しているプラグインを読み込んでいる。本来は init.el などの設定ファイルを全部読み込んだ状態でテストをした方が良さそうだが現状だとその状態で GitHub Actions で動かせる方法がわからないので一旦個別に読み込むようにしている。


#### swiper {#swiper}

ivy-read を使った機能のテストをするので読み込んでいる。

```emacs-lisp
(el-get-bundle abo-abo/swiper)
```


### テスト対象の読み込み {#テスト対象の読み込み}

テストしたいファイルをここで読んでる。

```emacs-lisp
;; テスト対象の読み込み
(load (expand-file-name (concat user-emacs-directory "/inits/68-my-org-commands.el")))
```


## ert-deftest {#ert-deftest}


### test:my/org-todo-keyword-strings {#test-my-org-todo-keyword-strings}

`org-todo-keywords` から "|" という区切りを除外したり
"(s)" とかのような高速アクセスのためのキーワードは
ivy で選択する時には邪魔なので除外したい、ということを表現したテスト。

```emacs-lisp
(ert-deftest test:my/org-todo-keyword-strings ()
  "Test of `my/org-todo-keyword-strings'."
  (let ((org-todo-keywords '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)"))))
    (should (equal '("TODO" "DOING" "WAIT" "DONE" "SOMEDAY")
                   (my/org-todo-keyword-strings)))))
```

なお、ここでテストしている関数では
TODO キーワードを ivy で扱いやすいように整えているだけで実際の選択は別の関数が担っている


### test:my/org-todo {#test-my-org-todo}

org-todo を ivy で選択する関数のテストを書いている。

```emacs-lisp
(ert-deftest test:my/org-todo ()
  "Test of `my/org-todo'."
  (let ((org-todo-keywords '((sequence "TODO" "DOING(!)" "WAIT" "|" "DONE(!)" "SOMEDAY(s)")))
        (result))
    ;; org-mode を読まずに済むように org-todo を差し替えてテストしている
    (cl-letf (((symbol-function 'org-todo)
               (lambda (keyword)
                 (setq result keyword))))
      (with-simulated-input "DOI RET" (my/org-todo))
      (should (equal "DOING" result)))))
```

ポイントは cl-letf を使って、内部で叩いている関数 `org-todo` を一時的に

```emacs-lisp
(lambda (keyword)
  (setq result keyword))
```

に差し替えているところ。

org-mode を呼び出さずに代わりの関数に差し替えているのでテストがしやすくなっている。Stub 的なやつかな。

何度も使うならこの差し替え処理自体をテストヘルパーにしても良いかもしれない。

また ivy で選択するので with-simulated-input を使って入力操作を代替している。便利。
