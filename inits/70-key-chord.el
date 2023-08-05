(el-get-bundle key-chord)

(setq key-chord-two-keys-delay           0.25
      key-chord-safety-interval-backward 0.1
      key-chord-safety-interval-forward  0.15)

(key-chord-mode 1)

(key-chord-define-global ";;"
                         'event-apply-shift-modifier)

(key-chord-define key-translation-map
                  ";;"
                  'event-apply-shift-modifier)
