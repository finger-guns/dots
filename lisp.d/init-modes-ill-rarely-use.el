;;; init-modes-ill-rarely-use.el --- finger__guns;
;;; Commentary:
;;; Just a whole bunch of modes i'll never really use.
;;; Code:

;; (use-package json
;;   :defer t
;;   :ensure t
;;   :config
;;   (setq js-indent-level 2)
;;   (setq tab-width 2))

(use-package dotenv-mode
  :defer t
  :ensure t)

(use-package csv-mode
  :defer t
  :ensure t)

;; (use-package gleam-mode
;;   :straight (gleam-mode :type git :host github :repo "gleam-lang/gleam-mode" :branch "gleam-ts-mode")
;;   :mode "\\.gleam\\'"
;;   :config
;;   (whitespace-mode t))

(load (expand-file-name "~/.quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")


(provide 'init-modes-ill-rarely-use)
