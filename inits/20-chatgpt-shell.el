(el-get-bundle chatgpt-shell)

(setopt chatgpt-shell-model-version "gemini-1.5-flash")
(setopt chatgpt-shell-google-key
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))
