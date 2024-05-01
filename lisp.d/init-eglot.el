;;; init-eglot.el --- finger___guns
;;; Commentary:
;;; eglot is the new thing.


(use-package dape
  :ensure (dape
             :type git
             :host github
             :repo "svaante/dape")
  :config
  (setq dape-inline-variables t))

(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :config
  (setq eglot-events-buffer-size 0)
  (setq eldoc-idle-delay 0.75)
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-noninterruptible)
  (setq eglot-extend-to-xref t)
  (add-to-list 'eglot-server-programs '(gleam-mode . ("gleam" "lsp")))
  )



(use-package combobulate
  :ensure (combobulate
             :host github
             :repo "mickeynp/combobulate")
  :config
  :preface
    ;; You can customize Combobulate's key prefix here.
    ;; Note that you may have to restart Emacs for this to take effect!
    (setq combobulate-key-prefix "C-c o")
    :hook
      ((python-ts-mode . combobulate-mode)
       (js-ts-mode . combobulate-mode)
       (html-ts-mode . combobulate-mode)
       (css-ts-mode . combobulate-mode)
       (yaml-ts-mode . combobulate-mode)
       (typescript-ts-mode . combobulate-mode)
       (json-ts-mode . combobulate-mode)
       (tsx-ts-mode . combobulate-mode))
  )
  



(provide 'init-eglot)
;;; init-eglot.el ends here.
