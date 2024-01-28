;;; init-treemacs --- finger__guns;
;;; Commentary:
;;; Just some treemacs.
;;; Code:

(use-package treemacs
  :straight t
  :config
  (setq treemacs-width 35)
  (setq treemacs-follow-mode t)
  (setq treemacs-filewatch-mode t)
  (setq treemacs-recenter-after-project-jump 'always)
  (setq treemacs-recenter-after-file-follow 'always)


  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag))
  )

(use-package treemacs-evil
  :after (treemacs evil)
  :straight t)


(provide 'init-treemacs)
;;; init-treemacs.el ends here.
