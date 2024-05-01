;;; init.el --- finger__guns;
;;; Commentary:
;;; What should emacs do on load, and how should it do it.
;;; Code:

;; (setq debug-on-error t)

(server-start)
;;; Let emacs know where we are.
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))

(defvar elpaca-installer-version 0.7)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                 ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                 ,@(when-let ((depth (plist-get order :depth)))
                                                     (list (format "--depth=%d" depth) "--no-single-branch"))
                                                 ,(plist-get order :repo) ,repo))))
                 ((zerop (call-process "git" nil buffer t "checkout"
                                       (or (plist-get order :ref) "--"))))
                 (emacs (concat invocation-directory invocation-name))
                 ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                       "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                 ((require 'elpaca))
                 ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  (elpaca-use-package-mode))

(elpaca-wait)

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
(require-init 'init-zig)
(require-init 'init-modes-ill-rarely-use)

;;; }}}

;;; }}}
