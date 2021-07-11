(el-get-bundle zk-phi/key-chord)

(setq key-chord-two-keys-delay           0.25
      key-chord-safety-interval-backward 0.1
      key-chord-safety-interval-forward  0.15)

(key-chord-mode 1)

(mapc (lambda (key)
        (key-chord-define-global (concat ";" (char-to-string key)) (char-to-string (- key 32))))
      (number-sequence ?a ?z))

(key-chord-define key-translation-map
                  ";;"
                  'event-apply-shift-modifier)
