(el-get-bundle rspec-mode)

;; rspec 実行バッファで byebug などで止った際に
;; C-x C-q したら inf-ruby が動くようにする
;; byebug か binding.irb 推奨。
;; binding.pry は何故かまともに動かない
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
