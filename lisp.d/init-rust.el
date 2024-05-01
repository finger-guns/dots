;;; init-rust.el --- finger__guns;
;;; Commentary:
;;; How to handle rust code.
;;; Code:

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :config
  (setq rust-format-on-save t))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))

(provide 'init-rust)
;;; init-rust.el ends here.
