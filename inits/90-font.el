(defun my/set-font-size (size)
  (let* ((asciifont "Ricty Diminished")      ; ASCII fonts
         (jpfont "Ricty Diminished")         ; Japanese fonts
         (h (* size 10))
         (fontspec (font-spec :family asciifont))
         (jp-fontspec (font-spec :family jpfont)))
    (set-face-attribute 'default nil :family asciifont :height h)
    (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
    (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
    (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
    (set-fontset-font nil '(#x0080 . #x024F) fontspec)
    (set-fontset-font nil '(#x0370 . #x03FF) fontspec)))

(if (or (eq window-system 'ns) (eq window-system 'mac))
    (my/set-font-size 14)
  (my/set-font-size 18))
