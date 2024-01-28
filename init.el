;;; init.el --- finger__guns;
;;; Commentary:
;;; What should emacs do on load, and how should it do it.
;;; Code:

;;(setq debug-on-error t)

;;; Let emacs know where we are.
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

;; ;;; don't GC during startup to save time
;; (unless (bound-and-true-p my-computer-has-smaller-memory-p)
;;   (setq gc-cons-percentage 0.6)
;;   (setq gc-cons-threshold most-positive-fixnum))

;;; Set the directories of some guff.
(defconst my-emacs-d (file-name-as-directory user-emacs-directory)
  "Directory of emacs.d.")

(defconst my-site-lisp-dir (concat my-emacs-d "site-lisp")
  "Directory of site-lisp.")

(defconst my-lisp-dir (concat my-emacs-d "lisp.d")
  "Directory of personal configuration.")

;; Light weight mode, fewer packages are used.
(setq my-lightweight-mode-p (and (boundp 'startup-now) (eq startup-now t)))

(defun require-init (pkg &optional maybe-disabled)
  "Load PKG if MAYBE-DISABLED is nil or it's nil but start up in normal slowly."
  (when (or (not maybe-disabled) (not my-lightweight-mode-p))
    (load (file-truename (format "%s/%s" my-lisp-dir pkg)) t t)))

(defun my-add-subdirs-to-load-path (lisp-dir)
  "Add sub-directories under LISP-DIR into `load-path'."
  (let* ((default-directory lisp-dir))
    (setq load-path
    (append
     (delq nil
     (mapcar (lambda (dir)
   (unless (string-match-p "^\\." dir)
     (expand-file-name dir)))
       (directory-files my-site-lisp-dir)))
     load-path))))

(setq gc-cons-threshold (* 100 1024 1024))
  
(require-init 'init-osx)
(require-init 'init-misc t)
(require-init 'init-package)


;;; --- Looks --- {{{
(require-init 'init-frame)
(require-init 'init-window)
(require-init 'init-dired)
;;; }}}

;;; --- Packages --- {{{

(require-init 'init-evil)
(require-init 'init-general)

;; ;; ;;; --- Completion --- {
(require-init 'init-completion)
;; ;;; }}}

;; ;; ;;; --- Linting --- {
(require-init 'init-flymake)
;; ;; ;;; }}}

;; ;; ;;; --- Actions --- {{{
(require-init 'init-embark)
(require-init 'init-consult)
;; ;; ;;; }}}

;; ;;; --- LSP --- {{{
(require-init 'init-eglot)
(require-init 'init-eldoc)

;; ;;; }}}

;; ;;; --- project --- {{{
(require-init 'init-project)
;; ;;; }}}

;; ;;; --- Programming Modes --- {{{
(require-init 'init-prog)
(require-init 'init-python)
(require-init 'init-go)
(require-init 'init-docker)
(require-init 'init-terraform)
(require-init 'init-typescript)
(require-init 'init-rust)
(require-init 'init-ocaml)
 ;; (require-init 'init-modes-ill-rarely-use)
;;; }}}

;;; }}}
