;;; init-consult.el --- finger__guns;
;;; Commentary:
;;; Complete Reading.
;;; Code:

(use-package vertico
  :straight t
  :init
  (vertico-mode))

;; Example configuration for Consult
(use-package consult
  :straight t
  :bind (
         ("C-x M-:" . consult-complex-command)
         ("C-x b" . consult-buffer)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi))

  ;; :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  :config
  (setq consult-preview-key "M-.")
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<")
)

(use-package embark-consult
  :straight t
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package deadgrep
  :straight t
  :general (:keymaps '(normal)
                     "M-s g" 'deadgrep)
  :init
  (evil-set-initial-state 'deadgrep-mode 'emacs))

(provide 'init-consult)
;;; init-consult.el ends here.
