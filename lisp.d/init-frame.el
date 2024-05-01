;;; init-frame.el --- finger__guns;
;;; Commentary:
;;; How Emacs frames should look.
;;; Code:

(use-package frame
  :init
  (setq redisplay-dont-pause t)
  :init
  (blink-cursor-mode -1)
  (setq-default fill-column 110
                display-fill-column-indicator-mode t)
  (menu-bar-mode -1))

(use-package scroll-bar
  :config
  (horizontal-scroll-bar-mode -1)
  (scroll-bar-mode -1))

(use-package faces
  :init
  (set-face-attribute 'default nil :font "mononoki" :weight 'regular :height 145)
  (set-face-attribute 'mode-line nil :font "Hack" :weight 'medium :height 130)
 ; (set-face-foreground 'flyspell-incorrect "purple")
 ; (set-face-attribute 'flyspell-incorrect nil :box '(:line-width 2 :color "#33333"))
 ; (set-face-attribute 'flyspell-incorrect-face nil :underline nil)
  (set-face-background 'cursor "#A9A9A9"))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :ensure t
  :hook ((python-mode emacs-lisp-mode rust-mode) . highlight-indent-guides-mode)
  :config
  (defun my-highlighter (level responsive display)
    (if (> 1 level)
	nil
      (highlight-indent-guides--highlighter-default level responsive display)))

  (setq highlight-indent-guides-highlighter-function 'my-highlighter)
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-auto-enabled nil)
  (set-face-foreground 'highlight-indent-guides-character-face "#3b444b"))


(provide 'init-frame)
;;; init-frame.el ends here.
