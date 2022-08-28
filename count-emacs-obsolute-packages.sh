#!/bin/bash

file="/tmp/emacs-outdated-packages.txt"
current=`date +%s`
last_modified=`stat -c "%Y" $file`

if [ $(($current-$last_modified)) -gt 3600 ]; then
    emacs --batch -Q -l ~/.emacs.d/el-get-lock-update-check.el --eval="(el-get-lock-update-check-print-obsolute-only)" > $file
fi

wc -l $file | cut -d " " -f 1
