;;; ~/.dotfiles/doom/layers/+python.el -*- lexical-binding: t; -*-

(after! anaconda-mode
  (setq conda-anaconda-home "~/.miniconda2"))

(defun +python/enable-lsp ()
  (unless pyvenv-virtual-env-name
    (pyvenv-workon "fides_processing"))
  (lsp))

(when (featurep! :lang python +lsp)
  (def-package! lsp-python-ms
    :config
    (add-hook! 'python-mode-hook #'+python/enable-lsp)))
