;;; init-osx.el --- finger__guns
;;; Commentary:
;;; Change how some modifiers act on osx.
;;; Code:

(when (eq system-type 'darwin)
  ;; use all the special keys on the mac keyboard
  (setq mac-option-modifier 'super
	ns-function-modifier nil
	mac-right-command-modifier 'super
	mac-right-option-modifier 'meta
	mac-command-modifier 'meta)
  (setq frame-title-format nil)
  (setq frame-resize-pixelwise t)
  (global-set-key (kbd "s-t") nil))

(provide 'init-osx)
;;; init-osx ends here.
