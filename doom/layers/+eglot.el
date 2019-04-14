;;; ~/.dotfiles/doom/layers/+eglot.el -*- lexical-binding: t; -*-


(def-package! eglot
  :hook ((haskell-mode rust-mode js2-mode typescript-mode)
         . eglot-ensure)
  :config
  (setq flymake-run-in-place nil
        temporary-file-directory "~/.emacs.d/tmp/"
        flymake-max-parallel-syntax-checks 8)
  (map! :leader
        :prefix "c" :desc "Help at Point" :n "h" #'eglot-help-at-point))
