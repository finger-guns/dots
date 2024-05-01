;;; init-evil.el --- finger__guns;
;;; Commentary:
;;; get evil son.
;;; Code:

(use-package evil
  :ensure t
  :demand t
  :bind (
         ("C-u" . evil-scroll-up)
         ("C-d" . evil-scroll-down))
  :config
  (unbind-key "C-z" evil-normal-state-map)
  (define-key evil-motion-state-map (kbd "C-z") 'nil)
  (define-key evil-motion-state-map (kbd ",") 'nil)
  (define-key evil-emacs-state-map (kbd "C-z") 'nil)
  (define-key evil-motion-state-map (kbd "C-x C-z") nil)
  (define-key evil-emacs-state-map (kbd "C-x C-z") 'nil)
  :init
  (evil-mode 1)
  (setq evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-width 2
        evil-shift-round t
        evil-want-C-u-scroll t
        evil-disable-insert-state-bindings t
        evil-want-Y-yank-to-eol t
        ))

(use-package evil-commentary
  :diminish evil-commentary-mode
  :ensure t
  :after evil
  :config
  (evil-commentary-mode))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode))

(provide 'init-evil)
;;; init-evil.el ends here.
