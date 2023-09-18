; init-completion.el --- finger__guns;
; Commentary:
; The completion framework to use.
; Code:

(use-package cape
  :straight t)

(use-package corfu
  :straight t
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-separator ?\s)
  (corfu-preview-current nil)
  (corfu-preselect-first nil)
  (corfu-on-exact-match nil)
  (corfu-echo-documentation nil)
  (corfu-scroll-margin 5)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.25)
  (corfu-min-width 80)
  (corfu-max-width corfu-min-width)
  :general (
            :keymaps '(normal insert)
                     :keymaps 'overide
                     "C-n" 'corfu-next
                     "C-p" 'corfu-previous
                     "C-g" 'corfu-quit
            :keymaps 'corfu-map
                      "SPC" 'corfu-insert-separator)
  
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
  :straight t
  :init
  (setq completion-styles '(orderless partial-completion basic)
	completion-category-defaults nil
	completion-category-overrides nil))

(use-package dash
  :straight t)

(use-package s
  :straight t)


(use-package copilot
  :straight (:host github :repo "zerolfx/copilot.el" :files ("dist" "*.el"))
  :hook ((elisp-mode . copilot-mode)
	 (prog-mode . copilot-mode)
	 (shell-mode . copilot-mode))
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
  :straight t
  :diminish t
  :after corfu
  :custom
  (kind-icon-use-icons t))

;; (use-package tabnine-capf
;;   :after cape
;;   :straight (:host github :repo "50ways2sayhard/tabnine-capf" :files ("*.el" "*.sh"))
;;   :hook (kill-emacs . tabnine-capf-kill-process)
;;   :config
;;   (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point))

(provide 'init-completion)
; init-completion.el ends here.
