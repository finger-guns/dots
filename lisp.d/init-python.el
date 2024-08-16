;;; init-python.el --- finger__guns;
;;; Commentary:
;;; How python-mode should act.
;;; Code:

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))

;; (use-package pyvenv
;;   :ensure t
;;   :hook (python-mode . pyvenv-mode))

(use-package blacken
  :ensure t
  :hook (python-ts-mode . blacken-mode)
  :commands blacken-buffer)

(use-package python
  :hook ((python-ts-mode . poetry-tracking-mode)
         (python-ts-mode . flyspell-prog-mode)
         (python-ts-mode . hs-minor-mode))
  :init
  (setq python-indent-def-block-scale 1)
  (setq python-shell-interpreter "ipython")
  (setq python-indent-guess-indent-offset t
        python-indent-guess-indent-offset-verbose nil))


(use-package poetry
  :ensure t
  :after (python-ts-mode))

(use-package python-isort
  :ensure t
  :hook (python-mode . python-isort-on-save-mode))

(use-package python-pytest
  :ensure t)

(provide 'init-python)
;;; init-python.el ends here.
