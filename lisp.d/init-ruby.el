(use-package enh-ruby-mode
  :ensure t
  :mode ("\\.rb\\'" "\\.rake\\'" "Rakefile\\'" "\\.ru\\'" "Gemfile\\'" "Capfile\\'")
  :interpreter "ruby"
  :hook
  ((enh-ruby-mode . subword-mode)   ;; Enable subword-mode for camelCase navigation
   (enh-ruby-mode . electric-pair-mode) ;; Auto-pair braces and quotes
   (enh-ruby-mode . show-paren-mode))  ;; Highlight matching parentheses
  :custom
  (enh-ruby-deep-indent-paren nil)    ;; Disable deep indentation for parentheses
  (enh-ruby-hanging-brace-deep-indent-level 0)) ;; Configure brace indentation


(provide 'init-ruby)
