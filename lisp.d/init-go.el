;;; init-go.el --- finger__guns;
;;; Commentary:
;;; Go seems fun
;;; Code

(use-package go-mode
  :ensure t
  :hook (go-mode . hs-minor-mode)
  :config
  ;; (add-hook 'eglot-managed-mode-hook (lambda ()
  ;;                  (remove-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))
  )

(provide 'init-go)
;;; init-go.el ends here.
