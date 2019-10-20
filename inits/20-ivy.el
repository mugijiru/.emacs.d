(el-get-bundle abo-abo/swiper) ;; ivy, swiper, counsel が同時に入って来る

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

(counsel-mode 1)

;; posframe を使って中央表示
(el-get-bundle ivy-posframe)
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
(ivy-posframe-mode 1)
