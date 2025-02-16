;;; init-eglot.el --- finger___guns
;;; Commentary:
;;; eglot is the new thing.


(use-package dape
  :ensure (dape
             :type git
             :host github
             :repo "svaante/dape")
  :config
  (setq dape-inline-variables t)

  (defun get-project-root ()
    "Get the current project root as a string, or return the `default-directory` if not in a project."
    (or (when-let ((project (project-current nil)))  ;; Avoid prompting with `nil`
          (project-root project))                   ;; Return project root if found
        default-directory))                         ;; Fallback to current directory
  (add-to-list 'dape-configs
               `(debugpy-remote-attach-port
                 modes (python-mode python-ts-mode)
                 host (lambda () (read-string "Host: " "localhost"))
                 port (lambda () (read-number "Port: "))
                 :request "attach"
                 :type "python"
                 :pathMappings [(:localRoot (lambda ()
                                              (read-directory-name "Local source directory: "
                                                                   (funcall dape-cwd-fn)))
                                            :remoteRoot (lambda ()
                                                          (read-string "Remote source directory: ")))]
                 :justMyCode nil
                 :showReturnValue t))
  )      

(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :config
  (setq eglot-events-buffer-size 0)
  (setq eldoc-idle-delay 0.75)
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-noninterruptible)
  (setq eglot-events-buffer-size 2000000)
  (setq eglot-extend-to-xref t)
  (add-to-list 'eglot-server-programs '(gleam-ts-mode . ("gleam" "lsp")))
  (add-to-list 'eglot-server-programs
               '(enh-ruby-mode . ("bundle" "exec" "ruby-lsp"))) ;; Use Ruby LSP from the project's bundle
  )



(use-package treesit
  :preface
  (defun mp-setup-install-grammars ()
    "Install Tree-sitter grammars if they are absent."
    (interactive)
    (dolist (grammar
             '((tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
               (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
               (yaml . ("https://github.com/ikatyang/tree-sitter-yaml" "master"))
               (python . ("https://github.com/tree-sitter/tree-sitter-python" "master"))))
      (add-to-list 'treesit-language-source-alist grammar)
      (unless (treesit-language-available-p (car grammar))
        (treesit-install-language-grammar (car grammar)))))
  )

(defun treesit-current-class-name ()
  "Return the name of the class at point using Tree-sitter."
  (when (treesit-available-p)
    (let ((node (treesit-node-at (point))))
      (while (and node
                  (not (member (treesit-node-type node)
                               '("class_declaration" "class_definition" "class_specifier"))))
        (setq node (treesit-node-parent node)))
      (when node
        (treesit-node-text (treesit-node-child-by-field-name node "name"))))))

(defun treesit-current-function-name ()
  "Return the name of the function at point using Tree-sitter."
  (when (treesit-available-p)
    (let ((node (treesit-node-at (point))))
      (while (and node
                  (not (member (treesit-node-type node)
                               '("function_definition" "method_declaration" "method_definition"))))
        (setq node (treesit-node-parent node)))
      (when node
        (treesit-node-text (treesit-node-child-by-field-name node "name"))))))

(defun treesit-show-current-class-name ()
  "Show the current class name in the echo area."
  (interactive)
  (let ((class-name (treesit-current-class-name)))
    (if class-name
        (message "Current Class: %s" class-name)
      (message "Not inside a class."))))

(defun treesit-show-current-function-name ()
  "Show the current function name in the echo area."
  (interactive)
  (let ((function-name (treesit-current-function-name)))
    (if function-name
        (message "Current Function: %s" function-name)
      (message "Not inside a function."))))

(defun treesit-current-class-and-function-segment ()
  "Return 'ClassName::FunctionName' for the modeline (empty string if none)."
  (let ((class-name (treesit-current-class-name))
        (function-name (treesit-current-function-name)))
    (cond
     ((and class-name function-name)
      (format " %s::%s " class-name function-name))
     (class-name
      (format " %s " class-name))
     (function-name
      (format " ::%s " function-name))
     (t ""))))

(setq-default mode-line-format
              (append mode-line-format
                      '((:eval (treesit-current-class-and-function-segment)))))

(provide 'init-eglot)
;;; init-eglot.el ends here.
