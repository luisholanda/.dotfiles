;;; init.el -*- lexical-binding: t; -*-

;; Copy this file to ~/.doom.d/init.el or ~/.config/doom/init.el ('doom
;; quickstart' will do this for you). The `doom!' block below controls what
;; modules are enabled and in what order they will be loaded. Remember to run
;; 'doom refresh' after modifying it.
;;
;; More information about these modules (and what flags they support) can be
;; found in modules/README.org.

(doom! :input

       :completion
       (company +childframe)
       (ivy +prescient +icons +childframe)

       :ui
       doom
       doom-dashboard
       doom-quit
       (emoji +unicode +github)
       hl-todo
       hydra
       indent-guides
       (ligatures +extra)
       modeline
       ophints
       (popup +defaults)
       unicode
       vc-gutter
       window-select
       workspaces
       zen

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       (parinfer +rust)
       snippets
       word-wrap

       :emacs
       electric
       (ibuffer +icons)
       undo
       vc

       :term
       vterm

       :checkers
       (syntax +childframe)
       (spell +aspell +everywhere)
       grammar

       :tools
       (debugger +lsp)
       (docker +lsp)
       (eval +overlay)
       (lookup +dictionary +offline)
       (lsp +peek)
       magit
       make
       rgb
       taskrunner
       terraform

       :os
       (:if IS-MAC macos)


       :lang
       (cc +lsp)
       data
       emacs-lisp
       json
       (javascript +lsp)
       (latex +latexmk +cdlatex +lsp +fold)
       lua
       (markdown +grip)
       nix
       (python +lsp +pyright +cython +pyenv)
       (rust +lsp)
       (sh +fish +lsp)
       (web +lsp)
       (yaml +lsp)

       :email
       ;; TODO: configure email
       ;;(mu4e +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app

       :config
       ;;literate
       (default +bindings +smartparens))
