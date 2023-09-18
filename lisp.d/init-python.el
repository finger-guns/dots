;;; init-python.el --- finger__guns;
;;; Commentary:
;;; How python-mode should act.
;;; Code:

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))

(use-package pyvenv
  :straight t
  :hook (python-ts-mode . pyvenv-mode))

(use-package blacken
  :straight t
  :hook (python-mode-ts-mode . blacken-mode)
  :commands blacken-buffer)

(use-package python
  :hook (python-ts-mode . poetry-tracking-mode)
  :init
  (setq python-indent-def-block-scale 1)
  (setq python-shell-interpreter "ipython")
  (setq python-indent-guess-indent-offset t
        python-indent-guess-indent-offset-verbose nil)
  )

(use-package poetry
  :straight t
  :after (python-ts-mode))

(use-package python-isort
  :straight t
  :hook (python-ts-mode . python-isort-on-save-mode))

(use-package python-pytest
  :straight t)

(provide 'init-python)
;;; init-python.el ends here.
