;;; init-frame.el --- finger__guns;
;;; Commentary:
;;; How Emacs frames should look.
;;; Code:

(use-package frame
  :init
  (setq redisplay-dont-pause t
        fill-column 110
        display-fill-column-indicator-mode t)
  (blink-cursor-mode -1)
  (menu-bar-mode -1))

(use-package scroll-bar
  :config
  (horizontal-scroll-bar-mode -1)
  (scroll-bar-mode -1))

(use-package faces
  :init
  (set-face-attribute 'default nil :font "Iosevka" :weight 'regular :height 145)
  (set-face-attribute 'mode-line nil :font "Hack" :weight 'medium :height 130)
  ;; Optional: for Emacs 30+ mode-line face split
  (when (facep 'mode-line-active)
    (set-face-attribute 'mode-line-active nil :font "Hack" :weight 'medium :height 130))
  (when (facep 'mode-line-inactive)
    (set-face-attribute 'mode-line-inactive nil :font "Hack" :weight 'medium :height 130))
  (set-face-background 'cursor "#A9A9A9"))

(use-package highlight-indent-guides
  :diminish highlight-indent-guides-mode
  :ensure t
  :hook ((prog-mode) . highlight-indent-guides-mode)
  :config
  (defun my-highlighter (level responsive display)
    (if (> 1 level)
        nil
      (highlight-indent-guides--highlighter-default level responsive display)))
  (setq highlight-indent-guides-highlighter-function #'my-highlighter
        highlight-indent-guides-method 'character
        highlight-indent-guides-character ?\|
        highlight-indent-guides-auto-enabled nil)
  (set-face-foreground 'highlight-indent-guides-character-face "#3b444b"))

(provide 'init-frame)
;;; init-frame.el ends here.
