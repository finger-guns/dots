;;; init-embark.el --- finger__guns;
;;; Commentary:
;;; Act on things.
;;; Code:

(use-package embark
  :ensure t
  :demand t
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(provide 'init-embark)
;;; init-embark.el ends here.
