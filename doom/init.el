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
       (spell +everywhere +hunspell +enchant)
       grammar

       :completion
       (company +childframe)
       (ivy
        +prescient
        ;+childframe
        +icons)

       :editor
       (evil +everywhere)
       fold
       (format +onsave)
       multiple-cursors
       snippets

       :emacs
       eletric
       (ibuffer +icons)

       :os
       macos

       :lang
       (cc +lsp)
       data
       emacs-lisp
       ;;(javascript +lsp)
       latex
       markdown
       ;;(org
       ;; +dragndrop
       ;; +ipython
       ;; +pandoc
       ;; +present)
       nix
       (python +lsp +pyright +pyenv)
       rest
       (rust +lsp)
       (sh +fish)
       yaml

       :tools
       (debugger +lsp)
       (docker +lsp)
       lookup
       (lsp +peek)
       make
       terraform

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       hydra ; todo: drop this after learn the keybindings
       indent-guides
       ligatures
       (modeline +light)
       nav-light
       ophints
       (popup
        +all
        +defaults)
       unicode
       vc-gutter
       zen

       :config
       ;;literate
       (default +bindings +smartparens))
