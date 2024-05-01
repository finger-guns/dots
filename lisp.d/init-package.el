;;; init-package.el --- finger__guns;
;;; Comentary:
;;; Use the straight-package manager.
;;; and setup diminish.

;;; Bootstrap straight.el

;; (defvar bootstrap-version)
;; (let ((bootstrap-file
;;        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
;;       (bootstrap-version 5))
;;   (unless (file-exists-p bootstrap-file)
;;     (with-current-buffer
;; 	(url-retrieve-synchronously
;; 	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
;; 	 'silent 'inhibit-cookies)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp)))
;;   (load bootstrap-file nil 'nomessage))

;; (straight-use-package 'use-package)
;; (setq use-package-verbose t)


(use-package diminish
  :ensure t)


(use-package async
  :ensure t
  :init
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1))

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-variables '("PATH" "GOPATH"))
  (exec-path-from-shell-initialize))

(provide 'init-package)
;;; init-package.el ends here.
