;;; init-project.el --- finger__guns;
;;; Commentary:
;;; How to manage projects.
;;; Code:

(use-package project
  :straight t
  :general
  (general-nvmap :prefix "C-x"
    "pf" 'project-find-file)
  :init
  (defcustom project-root-markers
    '("go.mod" "go.sum" "Cargo.toml" "compile_commands.json" "compile_flags.txt"
      "project.clj" ".git" "deps.edn" "shadow-cljs.edn" "tsconfig.json" "pyproject.toml" ".project")
    "Files or directories that indicate the root of a project."
    :type '(repeat string)
    :group 'project)

  (setq-default project-vc-ignores '("node_modules/" "bin/"))

  :config
  ;; Function to check the existence of a project marker in the given path
  (defun project-root-p (path)
    "Check if the current PATH has any of the project root markers."
    (catch 'found
      (dolist (marker project-root-markers)
	(when (file-exists-p (concat path marker))
	  (throw 'found marker)))))

  ;; Function to find the root based on the project-root-markers
  (defun project-find-root (path)
    "Search up the PATH for `project-root-markers'."
    (when-let ((root (locate-dominating-file path #'project-root-p)))
      (cons 'transient (expand-file-name root))))

  ;; Register the project-find-root function
  (add-to-list 'project-find-functions #'project-find-root)


  ;; Your custom buffer-saving functions and advice
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
  )

(provide 'init-project)
;;; init-project.el ends here.
