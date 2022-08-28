#!/bin/bash

file="/tmp/emacs-outdated-packages.txt"
current=`date +%s`
script_dir=$(cd $(dirname $0); pwd)

if [ ! -e $file ] || [ $(($current-$(stat -c "%Y" $file))) -gt 3600 ]; then
    emacs --batch -Q --eval "(setq user-emacs-directory \"${script_dir}/\")" -l ${script_dir}/el-get-lock-update-check.el --eval="(el-get-lock-update-check-print-obsolute-only)" | tee $file
fi

wc -l $file | cut -d " " -f 1
