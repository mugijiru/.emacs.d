(el-get-bundle engine-mode)
(engine-mode 1)

(defengine rurema-3.1
  "https://rurema.clear-code.com/version:3.1/query:%s/")

(defengine rurema-3.2
  "https://rurema.clear-code.com/version:3.2/query:%s/")

(defengine rurema-3.3
  "https://rurema.clear-code.com/version:3.3/query:%s/")

(defengine rails
  "https://apidock.com/rails/search?query=%s")

(defengine rspec
  "https://apidock.com/rspec/search?query=%s")

(defengine github-code
  "https://github.com/search?type=code&q=%s"
  :browser 'browse-url-default-browser)

(setopt engine/browser-function 'w3m-browse-url)
