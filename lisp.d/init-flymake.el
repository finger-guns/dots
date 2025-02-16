;;; init-flymake --- finger__guns -*- lexical-binding: t;-*-
;;; Commentary:
;;; trying out default package.s
;;; Code:

(use-package flymake
  :ensure t
  :after (eglot)
  :bind (:map flymake-mode-map
	      ("C-c ! n" . flymake-goto-next-error)
	      ("C-c ! p" . flymake-goto-previous-error)
	      ("C-c ! l" . flymake-show-buffer-diagnostics)
	      ("C-c ! v" . flymake-switch-to-log-buffer))

  :init
  (setq flymake-diagnostic-functions '(eglot-flymake-backend))

  :config
  (setq flymake-no-changes-timeout 0.1))

(provide 'init-flymake)
;;; init-flymake.el ends here
