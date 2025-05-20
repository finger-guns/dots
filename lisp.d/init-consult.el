;;; init-consult.el --- finger__guns;
;;; Commentary:
;;; Complete Reading.
;;; Code:

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package consult
  :ensure t
  :demand t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  ;; Register previews
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Xref integration
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Preview customization
  (setq consult-preview-key "M-.")

  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  ;; Narrowing key
  (setq consult-narrow-key "<"))


(provide 'init-consult)
;;; init-consult.el ends here.
