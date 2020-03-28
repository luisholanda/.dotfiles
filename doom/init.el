;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :checkers
       (syntax +childframe)
       grammar

       :completion
       (company +childframe)
       (ivy
        +fuzzy
        +childframe)

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       hydra
       indent-guides
       (modeline +light)
       ophints
       (popup
        +all
        +defaults)
       unicode
       vc-gutter

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       parinfer

       :emacs
       electric
       (ibuffer +icons)
       vc

       :tools
       (docker +lsp)
       lsp
       macos
       magit
       make

       :lang
       data
       emacs-lisp
       (javascript +lsp)
       latex
       markdown
       (org
        +dragndrop
        +ipython
        +pandoc
        +present)
       plantuml
       (python +lsp +pyenv)
       rest
       (rust +lsp)
       (sh +fish)

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       ;;literate

       (default +bindings))
