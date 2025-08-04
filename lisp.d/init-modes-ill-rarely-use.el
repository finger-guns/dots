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

;(use-package csv-mode
;  :defer t
;  :ensure t)

;; (use-package gleam-ts-mode
;;   :straight (:host github :repo "gleam-lang/gleam-mode")
;;   :mode ("\\.gleam\\'" . gleam-ts-mode))
;;   )

;; (load (expand-file-name "~/.quicklisp/slime-helper.el"))
;; (setq inferior-lisp-program "sbcl")

(use-package lua-ts-mode
  ;; :ensure t
  :mode ("\\.lua\\'" . lua-ts-mode)
  )



(provide 'init-modes-ill-rarely-use)
