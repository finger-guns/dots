;;; elixir-mode.el
;;; comentary:
;;; just trying out elixir mode
;;; code:


(use-package elixir-mode
  :ensure t
  :config
  (setq elixir-indent-level 2))

;; (use-package mix
;;     :ensure t
;;     :hook (elixir-mode . mix-mode))

  ;; Setup alchemist for additional Elixir tooling
  (use-package alchemist
    :ensure t
    :hook (elixir-mode . alchemist-mode)
    :config
    ;; Keybindings for common tasks
    (define-key alchemist-mode-map (kbd "C-c , t") 'alchemist-mix-test)
    (define-key alchemist-mode-map (kbd "C-c , c") 'alchemist-mix-compile)
    (define-key alchemist-mode-map (kbd "C-c , e") 'alchemist-iex-run))
  
(provide 'init-elixir)
