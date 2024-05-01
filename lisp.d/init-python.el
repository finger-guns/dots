;;; init-python.el --- finger__guns;
;;; Commentary:
;;; How python-mode should act.
;;; Code:

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)))

;; (use-package pyvenv
;;   :ensure t
;;   :hook (python-mode . pyvenv-mode))

(use-package blacken
  :ensure t
  :hook (python-ts-mode . blacken-mode)
  :commands blacken-buffer)

(use-package python
  :hook (python-ts-mode . poetry-tracking-mode)
  :init
  (setq python-indent-def-block-scale 1)
  (setq python-shell-interpreter "ipython")
  (setq python-indent-guess-indent-offset t
        python-indent-guess-indent-offset-verbose nil)
  :config
  ;; (setq-default eglot-workspace-configuration
  ;;               '((:pylsp . (:configurationSources ["flake8"]
  ;;                            :plugins (
  ;;                                      :pycodestyle (:enabled :json-false)
  ;;                                      :mccabe (:enabled :json-false)
  ;;                                      :pyflakes (:enabled :json-false)
  ;;                                      :flake8 (:enabled :json-false
  ;;                                               :maxLineLength 88)
  ;;                                      :ruff (:enabled t
  ;;                                             :lineLength 88)
  ;;                                      :pydocstyle (:enabled t
  ;;                                                   :convention "numpy")
  ;;                                      :yapf (:enabled :json-false)
  ;;                                      :autopep8 (:enabled :json-false)
  ;;                                      :black (:enabled t
  ;;                                              :line_length 88
  ;;                                              :cache_config t)))))))
(setq-default eglot-workspace-configuration
              '((:pylsp . (:configurationSources ["flake8"]
                           :plugins (
                                     :pycodestyle (:enabled :json-false)
                                     :mccabe (:enabled :json-false)
                                     :pyflakes (:enabled :json-false)
                                     :flake8 (:enabled :json-false
                                              :maxLineLength 88)
                                     :ruff (:enabled t
                                            :lineLength 88)
                                     :pydocstyle (:enabled t
                                                  :convention "numpy"
                                                  :addIgnore ["D100" "D101" "D102" "D103" "D104" "D105"])
                                     :yapf (:enabled :json-false)
                                     :autopep8 (:enabled :json-false)
                                     :black (:enabled t
                                             :line_length 88
                                             :cache_config t)
                                     :mypy (:enabled t
                                                     :followImports "silent")
                                     :jedi_hover (:enabled t)
                                     ))))))


(use-package poetry
  :ensure t
  :after (python-ts-mode))

(use-package python-isort
  :ensure t
  :hook (python-mode . python-isort-on-save-mode))

(use-package python-pytest
  :ensure t)

(provide 'init-python)
;;; init-python.el ends here.
