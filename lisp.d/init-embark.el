;;; init-embark.el --- finger__guns;
;;; Commentary:
;;; Act on things.
;;; Code:

(use-package embark
  :straight t
  :bind(
	("C-;" . embark-act)
	("C-." . embark-dwim)
	("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(provide 'init-embark)
;;; init-embark.el ends here.
