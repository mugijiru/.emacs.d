;; 同じ名前のファイルを開いている時に祖先ディレクトリ名を表示してくれてわかりやすくしてくれるやつ
(require 'uniquify) ;; includes Emacs
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
