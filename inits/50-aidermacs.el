(el-get-bundle aidermacs)

(setenv "GEMINI_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "gemini" :max 1)) :secret)))
(setenv "GROQ_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "groqcloud" :max 1)) :secret)))
(setenv "OPENROUTER_API_KEY"
        (funcall (plist-get (nth 0 (auth-source-search :host "openrouter" :max 1)) :secret)))

(setopt aidermacs-default-model "gemini-2.5-pro")
