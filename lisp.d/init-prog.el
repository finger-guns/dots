;;; init-prog.el --- finger__guns;
;;; Commentary:
;;; How all major prog modes should act.
;;; Code:

(defun conditional-disable-modes ()
  (when (> (buffer-size) (* 3 1024 1024))
    (flymake-mode -1)
    (font-lock-mode -1)
    (fundemental-mode -1)
    (which-function-mode -1)))

(use-package prog-mode
  :hook ( prog-mode . conditional-disable-modes )
  :init
  (setq-default indent-tabs-mode nil
                tab-width 2
                c-basic-indent 2
                c-basic-offset 2
                evil-shift-width 4
                indent-line-function 'insert-tab)
  )

(use-package electric
  :hook ((prog-mode . electric-indent-mode)))

;; (use-package ws-butler
;;   :straight t
;;   :hook (prog-mode . ws-butler-mode))

(provide 'init-prog)
;;; init-prog.el ends here.
