;;; ~/.dotfiles/doom/layers/+conda.el -*- lexical-binding: t; -*-
(after! anaconda-mode
  (setq conda-anaconda-home "~/.miniconda2"))

(after! ein
  (set! :ein-notebook-dir "~/Notebooks"))
  (map! :map* python-mode-map
        :localleader
        (:desc "Jupyter" :prefix "j"
         :desc "Start Server"  :n "s" #'ein:jupyter-server-start
         :desc "Login Jupyter" :n "l" #'ein:notebooklist-login
         :desc "Open Jupyter"  :n "o" #'ein:notebooklist-open))
