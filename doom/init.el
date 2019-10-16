;;; init.el -*- lexical-binding: t; -*-

(doom! :completion
       (company
        +childframe)
       (ivy
        +fuzzy
        +childframe
        +icons)

       :ui
       doom
       doom-dashboard
       doom-quit
       hl-todo
       indent-guides
       modeline
       nav-flash
       ophints
       (popup
        +all
        +defaults)
       unicode
       vc-gutter
       vi-tilde-fringe
       window-select

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       parinfer
       word-wrap

       :emacs
       vc

       :tools
       eval
       flycheck
       flyspell
       lookup
       lsp
       macos
       magit
       make

       :lang
       (cc +lsp)
       data
       emacs-lisp
       (javascript +lsp)
       markdown
       (python +lsp +pyenv)
       rest
       (rust +lsp)
       (sh +fish)
       (web +lsp)

       :config
       (default +bindings +smartparens))
