(el-get-bundle chatgpt-shell)

(setopt chatgpt-shell-model-version "gemini-2.0-flash")
(setopt chatgpt-shell-google-key
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))
