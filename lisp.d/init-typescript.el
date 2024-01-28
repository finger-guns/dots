;;; init-typescript.el --- finger__guns;
;;; Commentary:
;;; Typescript mode stuff.
;;; Code:



(use-package lsp-mode
  :straight t)

(use-package svelte-mode
  :straight t
  :hook (svelte-mode . add-node-modules-path)
  :config
  (setq svelte-basic-offset 2)
  )

(defun add-node-modules-path ()
  "Add node_modules/.bin to exec-path for the current project."
  (let* ((project (project-current))
         (root (when project (car (project-roots project)))))
    (when root
      (let ((node-modules-bin (expand-file-name "node_modules/.bin" root)))
        (when (file-directory-p node-modules-bin)
          (setenv "PATH" (concat node-modules-bin ":" (getenv "PATH")))
          (setq exec-path (append (list node-modules-bin) exec-path)))))))


(use-package typescript-ts-mode
  :mode ("\\.ts\\'" . typescript-ts-mode)
  :init
  (setq typescript-indent-level 2)
  (add-to-list 'eglot-server-programs '(typescript-mode . ("typescript-language-server" "--stdio"))))

(use-package vue-mode
  :straight t)


(provide 'init-typescript)
