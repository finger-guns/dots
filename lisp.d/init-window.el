;;; init-window.el --- finger__guns;
;;; Commentary:
;;; How Emacs windows should look.
;;; Code:

(use-package window
  :config
  (setq display-buffer-alist
        (append
         '(("\\*\\(Flycheck\\|Flymake\\|Package-Lint\\|vc-git :\\).*"
            (display-buffer-in-side-window)
            (window-height . 0.16)
            (side . top)
            (slot . 0)
            (window-parameters . ((no-other-window . t))))
           ("^\\(\\*E?shell\\|vterm\\).*"
            (display-buffer-in-side-window)
            (window-height . 0.16)
            (side . bottom)
            (slot . 1))
           ("\\*Help.*"
            (display-buffer-in-side-window)
            (window-width . 0.20)
            (side . right)
            (slot . 0)
            (window-parameters . ((no-other-window . t)))))
         '(("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
            nil
            (window-parameters (mode-line-format . none))))))
  )


(use-package display-fill-column-indicator
  :hook (prog-mode . display-fill-column-indicator-mode)
  :commands display-fill-column-indicator
  :init
  (setq global-display-fill-column-indicator-mode t)
  :config
  (setq display-fill-column-indicator t)
  (setq display-fill-column-indicator-character ?\N{U+2506}))


(use-package custom
  :init
  (add-to-list 'custom-theme-load-path (concat user-emacs-directory "themes.d/"))
  :config
  (load-theme 'modus-vivendi-tritanopia t)
  (setq modus-themes-mode-line '(accented borderless)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-fringes 'subtle
        modus-themes-tabs-accented t
        modus-themes-paren-match '(bold intense)
        modus-themes-prompts '(bold intense)
        modus-themes-completions 'opinionated
        modus-themes-org-blocks 'tinted-background
        modus-themes-scale-headings t
        modus-themes-region '(bg-only)
        modus-themes-headings
        '((1 . (rainbow overline background 1.4))
          (2 . (rainbow background 1.3))
          (3 . (rainbow bold 1.2))
          (t . (semilight 1.1))))


  (setq-default display-line-numbers 'relative
		display-line-numbers-width 4)
  ;;; Shut up.
  (setq ring-bell-function 'ignore)

  ;;; Smoth scroll.
 (setq scroll-preserve-screen-position t)
  (setq scroll-conservatively 101)

  )

(provide 'init-window)
;;; init-window.el ends here.
