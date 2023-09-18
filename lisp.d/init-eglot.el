;;; init-eglot.el --- finger___guns
;;; Commentary:
;;; eglot is the new thing.


(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :general (
            :prefix "C-c C-e"
                    :states '(normal visual insert emacs)
                    "r" 'eglot-rename
                    "f" 'eglot-format
                    "h" 'eglot-help-at-point
                    "d" 'xref-find-definitions
                    "D" 'xref-find-definitions-other-window
                    "R" 'eglot-find-references
                    "a" 'eglot-code-actions
                    )
  :config
  (add-to-list 'eglot-server-programs
               '(svelte-mode . ("svelteserver" "--stdio")))
  (setq eglot-events-buffer-size 0)
  (setq eldoc-idle-delay 0.75)
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-noninterruptible)
  )

(use-package treesit-parser-manager
  :straight (treesit-parser-manager
             :host codeberg
             :repo "ckruse/treesit-parser-manager"
             :files ("*.el"))
  :preface
  (dolist (mapping '((python-mode . python-ts-mode)
                     (css-mode . css-ts-mode)
                     (typescript-mode . tsx-ts-mode)
                     (js-mode . js-ts-mode)
                     (css-mode . css-ts-mode)
                     (yaml-mode . yaml-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping))

  :commands (treesit-parser-manager-install-grammars
             treesit-parser-manager-update-grammars
             treesit-parser-manager-install-or-update-grammars
             treesit-parser-manager-remove-grammar)
  :custom
  (treesit-parser-manager-grammars
   '(("https://github.com/tree-sitter/tree-sitter-rust"
      ("tree-sitter-rust"))

     ("https://github.com/ikatyang/tree-sitter-toml"
      ("tree-sitter-toml"))

     ("https://github.com/tree-sitter/tree-sitter-go"
      ("tree-sitter-go"))

     ("https://github.com/tree-sitter/tree-sitter-python"
      ("tree-sitter-python"))

     ("https://github.com/tree-sitter/tree-sitter-typescript"
      ("tree-sitter-typescript/tsx" "tree-sitter-typescript/typescript"))

     ("https://github.com/tree-sitter/tree-sitter-javascript"
      ("tree-sitter-javascript"))

     ("https://github.com/tree-sitter/tree-sitter-css"
      ("tree-sitter-css"))

     ("https://github.com/serenadeai/tree-sitter-scss"
      ("tree-sitter-scss"))

     ("https://github.com/tree-sitter/tree-sitter-json"
      ("tree-sitter-json"))))
  :config
  (add-to-list 'treesit-extra-load-path treesit-parser-manager-target-directory)
  ;; (setq-default treesit-font-lock-level 4)
  :hook (emacs-startup . treesit-parser-manager-install-grammars))



(provide 'init-eglot)
;;; init-eglot.el ends here.
