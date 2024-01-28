;;; init-ocaml.el
;;; Commentary:
;;; Code:

(defun esy-setup()
  (interactive)
  (let* ((esy-path-output (shell-command-to-string "esy command-env --json | jq -r '.PATH'"))
         (esy-paths (split-string esy-path-output path-separator)))
    (setq exec-path (append esy-paths exec-path))))

(use-package tuareg
  :straight t
  :mode (("\\.ml[ily]?$" . tuareg-mode)
         ("\\.topml$" . tuareg-mode))
  :config
  (setq tuareg-match-patterns-aligned t))

(use-package esy-mode
  :straight (esy-mode
             :type git
             :host github
             :repo "finger-guns/esy-mode")
  :hook ((tuareg-mode caml-mode) . esy-mode)

  :config
  (esy-setup))

(use-package opam-switch-mode
  :straight t
  :hook ((tuareg-mode) . opam-switch-mode))

(use-package merlin-eldoc
  :straight t
  :hook ((reason-mode tuareg-mode caml-mode) . merlin-eldoc-setup))

(use-package utop
  :straight t
  :hook (tuareg-mode . utop-minor-mode))

(use-package merlin
  :straight t
  :after tuareg
  :hook ((tuareg-mode . merlin-mode)))

;; Dune for building
(use-package dune
  :straight t
  :after tuareg)

;; Ocamlformat for formatting
(use-package ocamlformat
  :straight t
  :after tuareg
  :hook ((before-save . ocamlformat-before-save)))


(provide 'init-ocaml)
;;; init-ocaml.el ends here


