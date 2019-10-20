(el-get-bundle helm-posframe)
(helm-posframe-enable)

(defun helm-posframe-display (buffer &optional _resume)
  "The display function which is used by `helm-display-function'.
Argument BUFFER."
  (setq helm-posframe-buffer buffer)
  (posframe-show
   buffer
   :position (point)
   :poshandler helm-posframe-poshandler
   :width (or helm-posframe-width (- (window-width) 2))
   :height (or helm-posframe-height helm-display-buffer-height)
   :min-height 20
   :min-width 100
   :font helm-posframe-font
   :override-parameters helm-posframe-parameters
   :respect-header-line t))
