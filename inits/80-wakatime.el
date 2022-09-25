(el-get-bundle wakatime-mode)

(custom-set-variables
 '(wakatime-cli-path "/usr/bin/wakatime")
 '(wakatime-api-key (funcall (plist-get (nth 0 (auth-source-search :host "wakatime.com" :max 1)) :secret))))

(global-wakatime-mode 1)
