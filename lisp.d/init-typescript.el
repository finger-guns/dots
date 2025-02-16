;;; init-typescript.el --- finger__guns;
;;; Commentary:
;;; Typescript mode stuff.
;;; Code:



(use-package web-mode
  :ensure t
  :mode (".twig$" ".html?$" ".hbs$" ".vue$" ".blade.php$" ".svelte$" )
  :config
  (setq
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-style-padding 2
   web-mode-script-padding 2
   web-mode-enable-auto-closing t
   web-mode-enable-auto-opening t
   web-mode-enable-auto-pairing t
   web-mode-enable-auto-indentation t)
  )

;; (use-package svelte-mode
;;   :ensure t
;;   :hook (svelte-mode . add-node-modules-path)
;;   :init
;;   (lsp-mode)
;;   :config
;;   (setq svelte-basic-offset 2))

(defun add-node-modules-path ()
  "Add node_modules/.bin to exec-path for the current project."
  (let* ((project (project-current))
         (root (when project (car (project-roots project)))))
    (when root
      (let ((node-modules-bin (expand-file-name "node_modules/.bin" root)))
        (when (file-directory-p node-modules-bin)
          (setenv "PATH" (concat node-modules-bin ":" (getenv "PATH")))
          (setq exec-path (append (list node-modules-bin) exec-path)))))))


;; (use-package prettier
;;   :ensure t
;;   :hook ((typescript-ts-mode . prettier-mode)
;;          (tsx-ts-mode . prettier-mode)))

(use-package typescript-ts-mode
  :mode ("\\.ts\\'" . typescript-ts-mode)
  :config
  (setq typescript-ts-mode-indent-offset 2))

(use-package tsx-ts-mode
  :mode ("\\.tsx\\'" . tsx-ts-mode)
  :config
  (setq typescript-ts-mode-indent-offset 2))

(use-package vue-mode
  :ensure t)


(provide 'init-typescript)
