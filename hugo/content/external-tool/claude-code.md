+++
title = "claude-code.el"
draft = false
+++

## 概要 {#概要}

[claude-code.el](https://github.com/stevemolitor/claude-code.el) は [Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview) と連携するためのパッケージ。

今のところ入れてみたもののまともに動かないので、困っているけど、一応設定は書いておく


### インストール {#インストール}

まず recipe は el-get 本体にはないので自前で用意している。その際に依存している emacs-eat というパッケージの recipe も自前で用意した

```emacs-lisp
( :name emacs-eat
  :website "https://elpa.nongnu.org/nongnu-devel/doc/eat.html"
  :description "Eat (Emulate A Terminal) is a terminal emulator for Emacs."
  :type git
  :url "https://codeberg.org/akib/emacs-eat.git"
  :depends (compat)
  :branch "master")
```

```emacs-lisp
( :name claude-code
  :website "https://github.com/stevemolitor/claude-code.el"
  :description "An Emacs interface for Claude Code CLI"
  :type github
  :pkgname "stevemolitor/claude-code.el"
  :depends (emacs-eat transient)
  :branch "main")
```

そして `el-get-bundle` でインストールしている

```emacs-lisp
(el-get-bundle claude-code)
```


### 設定 {#設定}

```bash
$ claude migrate-installer
```

で `$HOME/.claude/local/claude` にインストールしたのでインストール先としてその PATH を指定している

```emacs-lisp
(setopt claude-code-program (expand-file-name "~/.claude/local/claude"))
```
