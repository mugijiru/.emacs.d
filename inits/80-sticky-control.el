(el-get-bundle sticky-control)

(sticky-control-set-key 'sticky-control-key ?,)

(setq sticky-control-shortcuts
      '((?c . "\C-c")
        (?g . "\C-g")
        (?k . "\C-k")
        (?a . "\C-a")
        (?e . "\C-e")
        (?n . "\C-n")
        (?o . "\C-o")
        (?p . "\C-p")
        (?j . "\C-j")
        (?f . "\C-f")
        (?b . "\C-b")
        (?x . "\C-x")
        (?r . "\C-r")
        (?s . "\C-s")))

(sticky-control-mode)
