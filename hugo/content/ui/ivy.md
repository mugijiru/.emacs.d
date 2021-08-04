+++
title = "ivy"
draft = false
+++

## 概要 {#概要}


## インストール {#インストール}

el-get を使って GitHub のリポジトリから直で入れている。

```emacs-lisp
(el-get-bundle abo-abo/swiper) ;; ivy, swiper, counsel が同時に入って来る
```

MELPA 経由だと org-mode 関係のパッケージ周りでハマったことがあるので
GitHub から直で入れる運用にしている。

が、やっぱり MELPA とかに寄せるべきかなって気になってきているところだったりもする。


## なんか設定 {#なんか設定}

便利に使えるようにするための設定を書いている。が、何を設定しているのかよく覚えてないので今度調べておこう……

```emacs-lisp
(when (require 'ivy nil t)
  ;; M-o を ivy-dispatching-done-hydra に割り当てる．
  (require 'ivy-hydra)

  ;; `ivy-switch-buffer' (C-x b) のリストに recent files と bookmark を含める．
  (setq ivy-use-virtual-buffers t)

  ;; ミニバッファでコマンド発行を認める
  (when (setq enable-recursive-minibuffers t)
    (minibuffer-depth-indicate-mode 1)) ;; 何回層入ったかプロンプトに表示．

  ;; ESC連打でミニバッファを閉じる
  (define-key ivy-minibuffer-map (kbd "<escape>") 'minibuffer-keyboard-quit)

  ;; (index/総数) 表示で何番目の候補かわかりやすくする
  (setq ivy-count-format "(%d/%d) ")

  ;; アクティベート
  (ivy-mode 1))
```


## counsel の有効化 {#counsel-の有効化}

counsel は ivy で提供されているやつで、既存の Emacs のコマンドを置き換えてくれるやつ。

とても便利なので当然有効にしている。

```emacs-lisp
(counsel-mode 1)
```


## ivy-posframe {#ivy-posframe}

ivy-posframe は ivy を posframe で表示してくれるようにするやつ。
posframe 表示だと Emacs の中央に表示できるので視線移動が少なく済んで便利。

```emacs-lisp
(el-get-bundle ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
(ivy-posframe-mode 1)
```


## ivy-rich {#ivy-rich}

ivy-rich は ivy の見た目をよりモダンにしてくれるやつ。なんだけど、オフにした時の表示どんな感じだったか忘れたな……。


### インストール {#インストール}

```emacs-lisp
(el-get-bundle ivy-rich)
```


### アイコン設定 {#アイコン設定}

いい感じにアイコンが表示されるように
<https://ladicle.com/post/config/#ivy> に書かれている関数を丸コピしてきた

```emacs-lisp
(defun ivy-rich-file-icon (candidate)
  "Display file icons in `ivy-rich'."
  (when (display-graphic-p)
    (let ((icon (if (file-directory-p candidate)
                    (cond
                     ((and (fboundp 'tramp-tramp-file-p)
                           (tramp-tramp-file-p default-directory))
                      (all-the-icons-octicon "file-directory"))
                     ((file-symlink-p candidate)
                      (all-the-icons-octicon "file-symlink-directory"))
                     ((all-the-icons-dir-is-submodule candidate)
                      (all-the-icons-octicon "file-submodule"))
                     ((file-exists-p (format "%s/.git" candidate))
                      (all-the-icons-octicon "repo"))
                     (t (let ((matcher (all-the-icons-match-to-alist candidate all-the-icons-dir-icon-alist)))
                          (apply (car matcher) (list (cadr matcher))))))
                  (all-the-icons-icon-for-file candidate))))
      (unless (symbolp icon)
        (propertize icon
                    'face `(
                            :height 1.1
                            :family ,(all-the-icons-icon-family icon)
                            ))))))
```


### switch-buffer でのアイコン表示 {#switch-buffer-でのアイコン表示}

公式に書かれてるように設定することでバッファを切り替える時もアイコンが表示されるようにしている。
<https://github.com/Yevgnen/ivy-rich#how-i-can-add-icons-for-ivy-switch-buffer>

```emacs-lisp
(defun ivy-rich-switch-buffer-icon (candidate)
  (with-current-buffer
      (get-buffer candidate)
    (let ((icon (all-the-icons-icon-for-mode major-mode)))
      (if (symbolp icon)
          (all-the-icons-icon-for-mode 'fundamental-mode)
        icon))))
```


### yank-pop の区切り設定 {#yank-pop-の区切り設定}

yank-pop の区切りをちょっと長めにしている。長い方が区切りだってわかりやすいので。

```emacs-lisp
(setq counsel-yank-pop-separator "\n--------------------\n")
```


### ivy-rich の表示設定 {#ivy-rich-の表示設定}

それぞれのカラムがどのぐらいの幅、みたいな設定をコマンド毎に設定できるようになっている。

```emacs-lisp
(setq ivy-rich-display-transformers-list
      '(ivy-switch-buffer
        (:columns
         ((ivy-rich-switch-buffer-icon :width 2)
          (ivy-rich-candidate (:width 30))
          (ivy-rich-switch-buffer-size (:width 7))
          (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right))
          (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))
          (ivy-rich-switch-buffer-project (:width 15 :face success))
          (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))
         :predicate
         (lambda (cand) (get-buffer cand)))
        counsel-M-x
        (:columns
         ((counsel-M-x-transformer (:width 40))  ; thr original transformer
          (ivy-rich-counsel-function-docstring (:face font-lock-doc-face))))  ; return the docstring of the command
        counsel-find-file
        (:columns
         ((ivy-rich-file-icon)
          (ivy-rich-candidate)))
        counsel-recentf
        (:columns
         ((ivy-rich-file-icon)
          (ivy-rich-candidate (:width 110))))
        ))
```


#### switch-buffer {#switch-buffer}

以下のような構成になっている。

| 列名    | 幅 | 内容                           |
|-------|---|------------------------------|
| アイコン | 2  | all-the-icons のアイコン表示幅の設定 |
| 候補名  | 30 | 選択候補名。バッファ名が表示される。 |
| バッファサイズ | 7  | 容量を示す。120.3k みたいな表示になる |
| インジケータ | 4  | 保存されてるかなどの表示。正直マーク何が何かわかってない |
| メジャーモード | 12 | そのバッファのメジャーモード。Org とか表示されたりする |
| プロジェクト名 | 15 | プロジェクト名の表示。.git があるフォルダ名が大体出てる |
| ファイルパス | 可変 | プロジェクト内でのファイル位置の表示 |

正直ファイル名以外あんまり気にしたことがない……。


#### M-x {#m-x}

コマンド選択時のやつは以下の構成になっている。

| 列名  | 幅   | 内容                             |
|-----|-----|--------------------------------|
| コマンド名 | 40   | 候補となるコマンド名の表示       |
| 概要  | 制限なし | コマンドの概要。docstring の1行目が表示されてるっぽい |


#### find-file {#find-file}

| 列名  | 幅  | 内容                        |
|-----|----|---------------------------|
| アイコン | 未設定 | all-the-icons のアイコン表示 |
| ファイル名 | 未設定 | カレントディレクトリ内のファイルが候補として表示される |


#### recentf {#recentf}

| 列名  | 幅  | 内容                  |
|-----|----|---------------------|
| アイコン | 未設定 | all-the-icons のアイコン表示 |
| ファイル名 | 110 | 最近使われたファイルが候補として表示される |

もうちょっと追加で情報表示できると便利かも。


### ivy-rich-mode の有効化 {#ivy-rich-mode-の有効化}

```emacs-lisp
(ivy-rich-mode 1)
```


### C-s で migemo れるようにする関数設定 {#c-s-で-migemo-れるようにする関数設定}

swiper は標準だと migemo れないのだが

<https://www.yewton.net/2020/05/21/migemo-ivy/>

でそれをできるようにしている記事があったので、それを元に入れている関数を追加して使えるようにしている。関数名などは書き換えてる

```emacs-lisp
(defun my/ivy-migemo-re-builder (str)
  (let* ((sep " \\|\\^\\|\\.\\|\\*")
         (splitted (--map (s-join "" it)
                          (--partition-by (s-matches-p " \\|\\^\\|\\.\\|\\*" it)
                                          (s-split "" str t)))))
    (s-join "" (--map (cond ((s-equals? it " ") ".*?")
                            ((s-matches? sep it) it)
                            (t (migemo-get-pattern it)))
                      splitted))))

(setq ivy-re-builders-alist '((t . ivy--regex-plus)
                              (swiper . my/ivy-migemo-re-builder)))
```

なんだけど
<https://github.com/ROCKTAKEY/ivy-migemo>
に乗り換えた方がいいのかな〜とも思っている。検証していきたい。


## counsel-osx-app. {#counsel-osx-app-dot}

Mac で Emacs を使ってる時に ivy でアプリケーションを起動するためのパッケージ。

```emacs-lisp
(el-get-bundle counsel-osx-app)
```

Mac を使ってる時は Emacs がランチャー代わりになるので便利。

WSL 使ってる時に同じようなことをしてみたいんだけどどうしたらいいんだろう。まあできなくてもいいんだけど、このパッケージは Mac でだけ読むようにしたら良いよねって感じではある。
