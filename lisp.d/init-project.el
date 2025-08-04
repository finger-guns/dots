;;; init-project.el --- finger__guns;
;;; Commentary:
;;; How to manage projects.
;;; Code:

(defcustom project-root-markers
  '("go.mod" "go.sum" "Cargo.toml" "compile_commands.json" "compile_flags.txt"
    "project.clj" ".git" "deps.edn" "shadow-cljs.edn" "tsconfig.json" "pyproject.toml" ".project")
  "Files or directories that indicate the root of a project."
  :type '(repeat string)
  :group 'project)

(defun project-root-p (path)
  "Check if the current PATH has any of the project root markers."
  (catch 'found
    (dolist (marker project-root-markers)
      (when (file-exists-p (concat path marker))
        (throw 'found marker)))))

(defun project-save-some-buffers (&optional arg)
  "Save some modified file-visiting buffers in the current project.
    Optional argument ARG (interactively, prefix argument) non-nil
    means save all with no questions."
  (interactive "P")
  (let* ((project-buffers (project-buffers (project-current)))
         (pred (lambda () (memq (current-buffer) project-buffers))))
    (funcall-interactively #'save-some-buffers arg pred)))

(define-advice project-compile (:around (fn) save-project-buffers)
  "Only ask to save project-related buffers."
  (let* ((project-buffers (project-buffers (project-current)))
         (compilation-save-buffers-predicate
          (lambda () (memq (current-buffer) project-buffers))))
    (funcall fn)))

(define-advice recompile (:around (fn &optional edit-command) save-project-buffers)
  "Only ask to save project-related buffers if inside a project."
  (if (project-current)
      (let* ((project-buffers (project-buffers (project-current)))
             (compilation-save-buffers-predicate
              (lambda () (memq (current-buffer) project-buffers))))
        (funcall fn edit-command))
    (funcall fn edit-command)))

(defun project-find-root (path)
  "Search up the PATH for `project-root-markers'."
  (when-let* ((root (locate-dominating-file path #'project-root-p)))
    (cons 'transient (expand-file-name root))))

(use-package project
  :ensure t
  :demand t
  :config
  (defun project-find-go-module (dir)
  (when-let* ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))
  (cl-defmethod project-root ((project (head go-module)))
    (cdr project))

  (add-hook 'project-find-functions #'project-find-go-module)
  (setq project-vc-ignores '("node_modules" ".mypy_cache" "dist" "__pycache__" ".venv", "_build", "deps"))

  :init
  (setq project-mode-line t)
  (advice-add #'project-find-regexp :override #'consult-ripgrep)
  (advice-add #'project-find-file :override #'consult-find)
  (add-to-list 'project-find-functions #'project-find-root))

;(use-package beframe
;  :ensure t
;  :demand t
;  :init
;  (beframe-mode t)
;  :config
;  (setq beframe-functions-in-frames '(project-prompt-project-dir)))

(provide 'init-project)
;;; init-project.el ends here.
