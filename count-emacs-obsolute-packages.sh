#!/bin/bash

file="/tmp/emacs-outdated-packages.txt"
current=`date +%s`
script_dir=$(cd $(dirname $0); pwd)

if [ ! -e $file ] || [ $(($current-$(stat -c "%Y" $file))) -gt 3600 ]; then
    emacs --batch -Q --eval "(setq user-emacs-directory \"${script_dir}/\")" \
          -l ${script_dir}/el-get-lock-update-check.el \
          --eval '(setq el-get-git-install-url "https://github.com/mugijiru/el-get.git")' \
          --eval '(setq el-get-install-branch "fix-install-for-emacs29")' \
          --eval "(el-get-lock-update-check-print-obsolute-only)" > $file
fi

wc -l $file | cut -d " " -f 1
