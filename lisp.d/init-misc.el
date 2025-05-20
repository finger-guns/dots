;;; init-misc.el --- finger__guns;
;;; Commentary:
;;; A whole bunch of misc settings for emacs.
;;; Code:

;; Load .dir-locals.el by default
(setq-default enable-local-variables t)

;; Number of bytes to read from subprocesses (helps with LSP)
(setq read-process-output-max (* 2048 2048))

;; Suppress unnecessary warnings (e.g. from LSP/compilation)
(setq warning-minimum-level :emergency)
(setq warning-suppress-log-types '((comp)))

;; Garbage collect on window blur
(add-hook 'focus-out-hook #'garbage-collect)

;; Don't start Emacs with split windows
(add-hook 'window-setup-hook #'delete-other-windows)

;; Separate custom.el to avoid polluting init.el
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; Follow symlinks without prompting
(setq vc-follow-symlinks t)

;; Use trash instead of deleting permanently
(setq trash-directory "~/.Trash"
      delete-by-moving-to-trash t)

;; Always use system clipboard
(setq x-select-enable-clipboard t)

;; Disable large file warnings
(setq large-file-warning-threshold nil)

;; Avoid creating newlines at EOF
(setq next-line-add-newlines nil)

;; Tooltips: faster display
(setq tooltip-delay 1.5)

;; Don't canonicalize filenames (faster file finding)
(setq find-file-use-truenames nil
      find-file-compare-truenames t)

;; Kill behavior
(setq kill-whole-line t
      kill-read-only-ok t)

;; Startup screen/message settings
(setq inhibit-splash-screen t
      initial-scratch-message ";; Welcome back to Emacs"
      initial-major-mode 'emacs-lisp-mode)

;; Disable lockfiles and backups in working dirs
(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil)

(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix emacs-tmp-dir)

;; UI behavior
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell nil)

;; Use Hunspell if available
(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell"
                ispell-really-hunspell t
                ispell-dictionary "en_AU"))

;; Clean up *Completions* buffer automatically (or better: suppress it)
(setq completion-auto-help 'lazy)

;; Prevent saving duplicate kills
(setq kill-do-not-save-duplicates t)

;; Suppress "Press q to quit" message in help windows
(advice-add 'help-window-display-message :override #'ignore)

(provide 'init-misc)
;;; init-misc.el ends here.
