(el-get-bundle key-chord)

(setopt key-chord-two-keys-delay 0.25)

(key-chord-mode 1)

(key-chord-define-global ";;"
                         'event-apply-shift-modifier)

(key-chord-define key-translation-map
                  ";;"
                  'event-apply-shift-modifier)
