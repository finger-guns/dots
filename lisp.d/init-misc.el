;;; init-misc.el --- finger__guns;
;;; Commentary:
;;; A whole bunch of misc settings for emacs.
;;; Code:


;; load .dir-locals.el by default
(setq-default enable-local-variables t)

;; nuber of bytes to read from subprocess
(setq read-process-output-max (* 2048 2048))

;; Stop warning me about every god damn thing, this is really useful for lsp things, should just re write that in lsp.el to set the default error level to be higher.
(setq warning-minimum-level :emergency)
(setq warning-suppress-log-types `((comp)))

;; Garbage collect whenever the window loses focus.
(add-hook 'focus-out-hook #'garbage-collect)

;; Don't open with splits
(add-hook 'window-setup-hook #'delete-other-windows)

;; Tell emacs where to put the custom/autoset settings, this stops init.el being flooded.
(setq custom-file (concat user-emacs-directory "/custom.el"))

;; Just follow shit.
(setq vc-follow-symlinks t)

;; Delete items to the trash.
(setq trash-directory "~/.Trash"
      delete-by-moving-to-trash t)

;; Always use x clipboard.
(setq  x-select-enable-clipboard t)

;; Let's not complain about big files.
(setq large-file-warning-threshold nil)

;; Avoid the end of buffer error.
(setq next-line-add-newlines nil)

;; Always try and load the newer version of the file.
;; (setq load-prefer-newer t)

;; Load the tool tip quicker and nicer.
(setq tooltip-delay 1.5)

;; Don't shorten names or anything.
(setq find-file-use-truenames nil
      find-file-compare-truenames t)

;; Complete what can be and don't complain about it!
(setq minibuffer-max-depth nil
      minibuffer-comfirm-incomplete t)

;; Kill everything.
(setq  kill-whole-line t
       kill-read-only-ok t)

;; Don't start up with a fancy slash screen, just give me org with a message.
(setq inhibit-splash-screen t
      initial-scratch-message ";; Welcome back to Emacs"
      initial-major-mode 'emacs-lisp-mode)

;; ;; Store all backup and autosave files in the tmp dir.
;; (setq backup-directory-alist
;;       `((".*" . ,temporary-file-directory)))
;; (setq auto-save-file-name-transforms
;;       `((".*" ,temporary-file-directory t)))

:; just fuck out of here with this.
(setq make-backup-files nil)
(setq create-lockfiles nil)

(defconst emacs-tmp-dir (expand-file-name (format "emacs%d" (user-uid)) temporary-file-directory))
(setq backup-directory-alist
    `((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms
    `((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix
    emacs-tmp-dir)

;; Go quick but be quite about it.
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell nil)

(when (executable-find "hunspell")
  (setq-default ispell-program-name "hunspell")
  (setq ispell-really-hunspell t)
  (setq ispell-dictionary "en_AU"))


;;; Remove a buffer called *Completions*.
(defun config--cleanup-completions-buffer ()
  (when-let* ((buf (get-buffer "*Completions*")))
    (kill-buffer buf)))

(add-hook 'minibuffer-exit-hook #'config--cleanup-completions-buffer)

;;; Don't save dups.
(setq kill-do-not-save-duplicates t)

;;; Don't show q to quit window.
(advice-add 'help-window-display-message :override #'ignore)

(defun undo-auto--undoable-change ()
"Called after every undoable buffer change."
;; (add-to-list 'undo-auto--undoably-changed-buffers (current-buffer))
;; (undo-auto--boundary-ensure-timer)
)
(setq timer-list (delq 'undo-auto--boundary-timer timer-list))

(provide 'init-misc)
;;; init-misc.el ends here.
