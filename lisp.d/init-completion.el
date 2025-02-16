; init-completion.el --- finger__guns;
; Commentary:
; The completion framework to use.
; Code:

(use-package cape
  :ensure t)

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-preview-current nil)
  (corfu-quit-no-match 'separator)
  (corfu-preselect-first nil)
  (corfu-on-exact-match nil)
  (corfu-echo-documentation nil)
  (corfu-scroll-margin 5)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)
  (corfu-preselect 'prompt)
  :hook ((elisp-mode . corfu-mode)
	 (prog-mode . corfu-mode)
	 (shell-mode . corfu-mode)
	 (eshell-mode . corfu-mode))
  :config
  (setq completion-category-overrides '((eglot (styles orderless))))
  :init
  (setq corfu-quit-no-match t)
  (setq completion-cycle-threshold 3
	read-extended-command-predicate #'command-completion-default-include-p))

(use-package orderless
  :ensure t
  :init
  (setq completion-styles '(orderless partial-completion basic)
	completion-category-defaults nil
	completion-category-overrides nil))

(use-package dash
  :ensure t)

(use-package s
  :ensure t)

(use-package emacs
  :custom
  (tab-always-indent 'complete))


(use-package tempel
  :ensure t
  :custom
  (tempel-trigger-prefix "<")
  :bind ("C-<" . tempel-insert))

(provide 'init-completion)
; init-completion.el ends here.
