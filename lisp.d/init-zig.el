;;; zig-mode.el --- finger__guns
;;; Commentary:
;;; nil
;;; Code:


(use-package zig-mode
  :ensure t
  :mode "\\.zig\\'"
  :config
  (add-hook 'zig-mode-hook
            (lambda ()
              (setq-local tab-width 4)
              (setq-local indent-tabs-mode nil)
              (setq-local c-basic-offset 4)
              (setq-local c-default-style "linux"))))
