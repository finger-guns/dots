;;; init-modes-ill-rarely-use.el --- finger__guns;
;;; Commentary:
;;; Just a whole bunch of modes i'll never really use.
;;; Code:

(use-package json
  :defer t
  :straight t
  :config
  (setq js-indent-level 2)
  (setq tab-width 2))

(use-package dotenv-mode
  :defer t
  :straight t)

(use-package csv-mode
  :defer t
  :straight t)

(provide 'init-modes-ill-rarely-use)
