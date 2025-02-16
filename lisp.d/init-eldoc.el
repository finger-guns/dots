;;; init-eldoc.el --- finger___guns
;;; Commentary:
;;; eldoc.

(use-package eldoc-box
  :ensure t
  :diminish ""
  :hook ((eldoc-mode . eldoc-box-hover-mode)
         (eglot--managed-mode . eldoc-box-hover-at-point-mode))
  :config
  (setq eldoc-echo-area-use-multiline-p t)
  (diminish 'eldoc-box-hover-mode "")
  (diminish 'eldoc-box-hover-at-point-mode "")
  )

(use-package eldoc
  :diminish ":edoc:")

(provide 'init-eldoc)
;;; init-eldoc.el ends here
