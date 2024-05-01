;;; init-general.el --- finger__guns
;;; Commentary:
;;; Key binginds with general.
;;; Code:

;; (global-set-key (kbd "C-h") nil)
;; (global-unset-key (kbd "C-h"))

(use-package general
  :after (evil)
  :ensure t
  :demand t
  :config
  (general-evil-setup t)
  (general-auto-unbind-keys)

  (general-define-key
   :prefix ","
   :states '(normal motion emacs)
   "pp" 'project-switch-project
   "pf" 'project-find-file
   "pr" 'project-find-regexp
   "pd" 'project-dired
   "l" 'consult-line
   "g" 'consult-ripgrep
   "f" 'consult-find
   "r" 'eglot-rename
   "f" 'eglot-format
   "h" 'eglot-help-at-point
   "d" 'xref-find-definitions
   "D" 'xref-find-definitions-other-window
   "R" 'xref-find-references
   "a" 'eglot-code-actions
   "," 'embark-act
   "." 'embark-dwim
   )

  (general-define-key
   :keymaps '(normal insert)
   "C-n" 'corfu-next
   "C-p" 'corfu-previous
   "C-g" 'corfu-quit)

  (general-define-key
   :keymaps 'corfu-map
   "SPC" 'corfu-insert-separator) 

   

  :init
  (general-def :states '(normal motion emacs) "," nil))

(provide 'init-general)
;;; init-general.el ends here.
