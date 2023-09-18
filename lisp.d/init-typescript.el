;;; init-typescript.el --- finger__guns;
;;; Commentary:
;;; Typescript mode stuff.
;;; Code:


(use-package typescript-ts-mode
  :mode ("\\.ts\\'" . typescript-ts-mode)
  :config
  (add-hook 'eglot-managed-mode-hook (lambda () (remove-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))
  :init
  (setq typescript-indent-level 2))


(use-package svelte-mode
  :straight t
  :config
  (setq svelte-basic-offset 2))

(provide 'init-typescript)
