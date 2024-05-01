;;; init-consult.el --- finger__guns;
;;; Commentary:
;;; Complete Reading.
;;; Code:

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  :demand t
  :hook (completion-list-mode . consult-preview-at-point-mode)
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
  :ensure t
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;(use-package deadgrep
;  :ensure t
;  :demand t
;  :general (:states 'normal :prefix "SPC" 
;                     "g" 'deadgrep)
;  :init
;  (evil-set-initial-state 'deadgrep-mode 'emacs))

(provide 'init-consult)
;;; init-consult.el ends here.
