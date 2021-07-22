+++
title = "org-trello"
draft = false
weight = 11
+++

## 概要 {#概要}

[org-trello](https://org-trello.github.io/) は org-mode を使って Trello のタスクを管理するためのパッケージ。


## インストール {#インストール}

いつも通り el-get でインストールしている

```emacs-lisp
(el-get-bundle org-trello)
```


## 同期するコマンドの用意 {#同期するコマンドの用意}

バッファと Trello との同期する関数はあるのだけどコマンドにはなっていなかったので同期するためのコマンドを用意している

```emacs-lisp
(defun my/org-trello-fetch-buffer ()
  (interactive)
  (org-trello-sync-buffer t))
```


## キーバインド設定 {#キーバインド設定}

キーバインドは覚えられないので、いつも通り [pretty-hydra](https://github.com/jerrypnz/major-mode-hydra.el#pretty-hydra) で Hydra のやつを用意している

```emacs-lisp
(with-eval-after-load 'pretty-hydra
  (pretty-hydra-define
    org-trello-hydra
    (:separator "-"
                :color teal
                :foreign-key warn
                :title (concat (all-the-icons-faicon "trello") "  Org Trello commands")
                :quit-key "q")
    ("Install"
     (("i" org-trello-install-board-metadata "Board metadata")
      ("I" org-trello-install-key-and-token "Setup"))

     "Sync"
     (("s" my/org-trello-fetch-buffer "← Trello")
      ("S" org-trello-sync-buffer "→ Trello"))

     "Other"
     (("V" org-trello-version "Version")))))
```

| Key | 効果                  |
|-----|---------------------|
| i   | Board のメタデータをインストールする |
| I   | Key と トークンを設定する |
| s   | Trello の情報を引っ張ってくる |
| S   | Trello の情報を連携する |
| V   | バージョン情報を表示  |


## その他 {#その他}

まだ試していないが
<https://github.com/gizmomogwai/org-kanban>
と組み合わせるとビジュアル的に見れて嬉しいとかあるかもしれない
