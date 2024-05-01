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


(use-package copilot
  :ensure t
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  ;; :hook (prog-mode . copilot-mode)
  :bind (
         ("M-y" . copilot-accept-completion-by-line)
         ("M-Y" . copilot-accept-completion)
         ("M-J" . copilot-next-completion)
         ("M-K" . copilot-previous-completion)
         ("M->" . copilot-next-completion)
         ("M-<" . copilot-previous-completion)
         )
  )

(use-package kind-icon
  :ensure t
  :diminish t
  :after corfu
  :custom
  (kind-icon-use-icons t))

(provide 'init-completion)
; init-completion.el ends here.
