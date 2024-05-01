;;; init-eldoc.el --- finger___guns
;;; Commentary:
;;; eldoc.

(use-package eldoc-box
  :ensure t
  :diminish "e"
  :hook ((eldoc-mode . eldoc-box-hover-mode)
         (eglot--managed-mode . eldoc-box-hover-mode))
  )

(provide 'init-eldoc)
;;; init-eldoc.el ends here
