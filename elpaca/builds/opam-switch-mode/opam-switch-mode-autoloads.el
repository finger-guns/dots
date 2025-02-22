;;; opam-switch-mode-autoloads.el --- automatically extracted autoloads (do not edit)   -*- lexical-binding: t -*-
;; Generated by the `loaddefs-generate' function.

;; This file is part of GNU Emacs.

;;; Code:



;;; Generated autoloads from opam-switch-mode.el

(autoload 'opam-switch-set-switch "opam-switch-mode" "\
Choose and set an opam switch.
Set opam switch SWITCH-NAME, which must be a valid opam switch
name.  When called interactively, the switch name must be entered
in the minibuffer, which forces completion to a valid switch name
or the empty string.

Setting the opam switch for the first time inside Emacs will save
the current environment.  Using the empty string for SWITCH-NAME
will reset the environment to the saved values.

The switch is set such that all process invocations from
Emacs respect the newly set opam switch.  In addition to setting
environment variables such as PATH and CAML_LD_LIBRARY_PATH, this
also sets variable `exec-path', which controls Emacs'
subprocesses (`call-process', `make-process' and similar
functions).

When the switch is changed, `opam-switch-change-opam-switch-hook'
runs.  This a can be used to inform other modes that may run
background processes that depend on the currently active opam
switch.

For obvious reasons, `opam-switch-set-switch' will only affect Emacs and
not any other shells outside Emacs.

(fn SWITCH-NAME)" t)
(autoload 'opam-switch-mode "opam-switch-mode" "\
Toggle opam-switch mode.

The mode can be enabled only if opam is found and \"opam var root\" succeeds.

This is a minor mode.  If called interactively, toggle the `Opam-Switch
mode' mode.  If the prefix argument is positive, enable the mode, and if
it is zero or negative, disable the mode.

If called from Lisp, toggle the mode if ARG is `toggle'.  Enable the
mode if ARG is nil, omitted, or is a positive number.  Disable the mode
if ARG is a negative number.

To check whether the minor mode is enabled in the current buffer,
evaluate the variable `opam-switch-mode'.

The mode's hook is called both when the mode is enabled and when it is
disabled.

(fn &optional ARG)" t)
(register-definition-prefixes "opam-switch-mode" '("opam-switch-"))

;;; End of scraped data

(provide 'opam-switch-mode-autoloads)

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; no-native-compile: t
;; coding: utf-8-emacs-unix
;; End:

;;; opam-switch-mode-autoloads.el ends here
