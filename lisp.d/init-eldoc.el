;;; init-eldoc.el --- finger___guns
;;; Commentary:
;;; eldoc.

;;; Code:

;; (use-package eldoc-box
;;   :ensure t
;;   :diminish ""
;;   :hook ((eldoc-mode . eldoc-box-hover-mode)
;;          (eglot--managed-mode . eldoc-box-hover-at-point-mode))
;;   :config
;;   (diminish 'eldoc-box-hover-mode "")
;;   (diminish 'eldoc-box-hover-at-point-mode ""))


(use-package eldoc
  :diminish ":edoc:"
  :custom (when (fboundp 'eldoc-documentation-compose-single)
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose-single))
  :config
   (setq eldoc-echo-area-use-multiline-p t)
  )

(provide 'init-eldoc)
;;; init-eldoc.el ends here
