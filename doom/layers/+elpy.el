;;; ~/.dotfiles/doom/layers/+elpy.el -*- lexical-binding: t; -*-

(def-package! elpy
  :hook (python-mode . elpy-enable)
  :init
  (setq elpy-company-add-completition-from-shell t)
  :config
  (set-company-backend! 'python-mode '(elpy-company-backend)))
