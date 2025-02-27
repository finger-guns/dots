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
  "Return 'ClassName::FunctionName' with color for the modeline (empty string if none)."
  (let* ((class-name (treesit-current-class-name))
         (function-name (treesit-current-function-name))
         (class-name-colored (when class-name
                               (propertize class-name 'face '(:foreground "blue"))))
         (function-name-colored (when function-name
                                  (propertize function-name 'face '(:foreground "green")))))

    (cond
     ((and class-name-colored function-name-colored)
      (format " %s::%s " class-name-colored function-name-colored))
     (class-name-colored
      (format " %s " class-name-colored))
     (function-name-colored
      (format " %s " function-name-colored))
     (t ""))))

(defun treesit-get-indentation-info ()
  "Return a plist with the max indentation level in the current function 
   and the indentation level of the current line using Tree-sitter."
  (when (treesit-available-p)
    (let* ((root (treesit-buffer-root-node))
           (current-pos (point))
           (current-line (line-number-at-pos))
           (max-depth 0)
           (current-line-depth 0)
           (function-node (treesit-node-at current-pos))
           ;; Define common function node types across multiple languages
           (function-types '("function_definition"  ; Python
                             "function_declaration" "method_definition" "arrow_function"  ; JS/TS
                             "function_declaration" "method_declaration")))  ; Go

      ;; Find the nearest enclosing function-like node
      (while (and function-node
                  (not (member (treesit-node-type function-node) function-types)))
        (setq function-node (treesit-node-parent function-node)))

      (when function-node
        (cl-labels ((traverse (node depth)
                              (setq max-depth (max max-depth depth))
                              ;; Check if the current line is within this node
                              (when (= (line-number-at-pos (treesit-node-start node)) current-line)
                                (setq current-line-depth depth))
                              (dolist (child (treesit-node-children node))
                                (let ((child-type (treesit-node-type child)))
                                  (traverse child
                                            (if (member child-type '("block" "suite" "statement_block"))  ; Indented blocks
                                                (1+ depth)
                                              depth))))))
          (traverse function-node 0)))

      ;; Return the result as a plist
      (list :max-depth max-depth :current-line-depth current-line-depth))))

(defun treesit-indentation-info ()
  "Echo the maximum indentation level in the current function 
   and the indentation level of the current line using Tree-sitter."
  (interactive)
  (let ((info (treesit-get-indentation-info)))
    (if info
        (message "Max indentation depth: %d | Current line depth: %d"
                 (plist-get info :max-depth) (plist-get info :current-line-depth))
      (message "No function found at point."))))

(defun treesit-indentation-modeline-segment ()
  "Return a mode-line segment showing the current function's indentation levels.
   - If current indentation ≥ 3, it turns yellow.
   - If max indentation > 3, it turns red."
  (let ((info (treesit-get-indentation-info)))
    (if info
        (let* ((current (plist-get info :current-line-depth))
               (max-depth (plist-get info :max-depth))
               (color (cond
                       ((> max-depth 3) "red")
                       ((>= current 3) "yellow")
                       (t "white")))
               (formatted (format "%d/%d" current max-depth)))
          (propertize formatted 'face `(:foreground ,color)))
      ""))) ;; Return empty string if no function found

(setq-default mode-line-format
              (append mode-line-format
                      '((:eval (treesit-current-class-and-function-segment))
                        (:eval (treesit-indentation-modeline-segment)))))


(provide 'init-eglot)
;;; init-eglot.el ends here.
