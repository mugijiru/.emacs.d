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


### counsel-locate-cmd の設定 {#counsel-locate-cmd-の設定}

環境によってシステム全体を検索するコマンドが異なるのでここで指定している。
Mac は mdfind を使いそれ以外ではデフォルトの locate を使う。

```emacs-lisp
(custom-set-variables '(counsel-locate-cmd (if (eq window-system 'mac)
                                               'counsel-locate-cmd-mdfind
                                             'counsel-locate-cmd-default)))
```

counsel.el を見てると
Windows では counsel-locate-cmd-es が使われるようだけど
Windows 環境を使ってないので無視。
<https://github.com/abo-abo/swiper/blob/d28225e86f8dfb3825809ad287f759f95ee9e479/counsel.el#L2567-L2573>


## ivy-posframe {#ivy-posframe}

ivy-posframe は ivy を posframe で表示してくれるようにするやつ。
posframe 表示だと Emacs の中央に表示できるので視線移動が少なく済んで便利。


### インストール {#インストール}

こちらは自前で el-get の resipe を用意している

```emacs-lisp
(:name ivy-posframe
       :type github
       :description "ivy-posframe is a ivy extension, which let ivy use posframe to show its candidate menu."
       :pkgname "tumashu/ivy-posframe"
       :minimum-emacs-version (26))
```

そしていつも通りに el-get でインストール

```emacs-lisp
(el-get-bundle ivy-posframe)
```


### 設定 {#設定}

Swiper だけは画面下部に表示されるようにしているが他は画面中央に表示されるようにしている。

Swiper は検索なので、真ん中に表示しているとヒットした部分が隠されてしまう。というわけでそいつだけは下に表示しているのでした。

```emacs-lisp
(setq ivy-posframe-display-functions-alist
      '((swiper . ivy-display-function-fallback)
        (t . ivy-posframe-display-at-frame-center)))
```


### 有効化 {#有効化}

```emacs-lisp
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


### C-s で migemo れるように ivy-migemo を導入・設定 {#c-s-で-migemo-れるように-ivy-migemo-を導入-設定}

swiper は標準だと migemo れないのだが

<https://github.com/ROCKTAKEY/ivy-migemo>

でそれをできるようにした。


#### インストール {#インストール}

```emacs-lisp
(:name ivy-migemo
       :website "https://github.com/ROCKTAKEY/ivy-migemo"
       :description "Use migemo on ivy."
       :type github
       :pkgname "ROCKTAKEY/ivy-migemo")
```

でレシピを用意して

```emacs-lisp
(el-get-bundle ivy-migemo)
```

で入れている。


#### キーバインドの設定 {#キーバインドの設定}

以下を入れておくと migemo を使ったり fuzzy を使ったりを切り替えられるようなのでとりあえず設定している。

```emacs-lisp
(define-key ivy-minibuffer-map (kbd "M-f") #'ivy-migemo-toggle-fuzzy)
(define-key ivy-minibuffer-map (kbd "M-m") #'ivy-migemo-toggle-migemo)
```

なおこれは公式に記載されている設定である。


#### デフォルトで migemo を有効にする {#デフォルトで-migemo-を有効にする}

swiper を使う時はデフォで有効になっててほしいのでその設定も入れている。なおこれも公式ページに記述されている設定である。

というか全体を ivy-migemo-regex-plus にしている。これは completing-read-function で指定されている ivy-completing-read でも migemo りたかったため。
completing-read や ivy-completing-read を指定してもうまくいかないのでもうエイヤで全部 migemo に倒した

```emacs-lisp
(with-eval-after-load 'ivy-migemo
  (setq ivy-re-builders-alist '((t . ivy-migemo-regex-plus)
                                (counsel-M-x . ivy--regex-plus)
                                (counsel-describe-function . ivy--regex-plus)
                                (counsel-describe-variable . ivy--regex-plus)
                                (swiper . ivy-migemo-regex-plus)
                                (counsel-find-file . ivy-migemo-regex-plus))))
```

また fuzzy match を有効にする設定も記載されているがそちらは自分は設定していない。なんとなく。


## ivy-kibela {#ivy-kibela}

Kibela の記事を ivy で絞り込んで Emacs から開けるようにするために
[ivy-kibela](https://github.com/mugijiru/ivy-kibela) という自作ツールを使っている


### インストール {#インストール}

以下のレシピを用意して

```emacs-lisp
(:name ivy-kibela
       :website "https://github.com/mugijiru/ivy-kibela"
       :description "Ivy interface to kibela."
       :type github
       :branch "main"
       :pkgname "mugijiru/ivy-kibela")
```

```emacs-lisp
(el-get-bundle ivy-kibela)
```

を設定ファイルに書いておけば OK


### 有効化 {#有効化}

今のところ明示的に require しないといけない。
ivy が読まれてから読まれて欲しいので、以下のように設定している。

```emacs-lisp
(with-eval-after-load 'ivy
  (require 'ivy-kibela))
```


### 設定 {#設定}

README に従い `ivy-kibela-team` と `ivy-kibela-access-token` を設定してあげれば OK。自分は authinfo を使ってるのでそれ経由で値を取得している。

```emacs-lisp
(custom-set-variables
 '(ivy-kibela-team (plist-get (nth 0 (auth-source-search :host "kibe.la")) :team))
 '(ivy-kibela-access-token (funcall (plist-get (nth 0 (auth-source-search :host "kibe.la" :max 1)) :secret))))
```


### ivy-migemo の有効化 {#ivy-migemo-の有効化}

ivy-kibela でも migemo りたかったので、以下のようにして migemo でも使えるようにしている

```emacs-lisp
(with-eval-after-load 'ivy-kibela
  (add-to-list 'ivy-re-builders-alist '(ivy-kibela . ivy-migemo-regex-plus) t))
```


## prescient.el {#prescient-dot-el}

[prescient.el](https://github.com/raxod502/prescient.el) は強力なソート・フィルタ機能を提供してくれるパッケージ。
ivy などの絞り込み系ツールと組み合わせて使う。

とりあえずいつも通り el-get でインストールしている。

```emacs-lisp
(el-get-bundle prescient.el)
```

レシピは自前で追加している

```emacs-lisp
(:name prescient.el
       :website "https://github.com/radian-software/prescient.el"
       :description "simple but effective sorting and filtering for Emacs."
       :type github
       :branch "main"
       :pkgname "radian-software/prescient.el")
```

そんで ivy でそれが使われるように ivy-prescient-mode を有効にしている。

```emacs-lisp
(ivy-prescient-mode 1)
```

ただ候補文字列の長さで sort されるのはどうも微妙さを感じるので無効にしている。

```emacs-lisp
(setq prescient-sort-length-enable nil)
```

どうやら company-mode でも使えるらしいので設定は別のところに分離した方がいいかもしれない。
