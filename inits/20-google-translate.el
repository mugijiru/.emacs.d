(el-get-bundle google-translate)

(defun google-translate--search-tkk ()
  "Search TKK."
  (list 430675 2721866130))

(require 'google-translate-default-ui)

(custom-set-variables
  '(google-translate-default-source-language "en")
  '(google-translate-default-target-language "ja")
  '(google-translate-output-destination 'popup))
