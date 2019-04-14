;;; ~/.dotfiles/doom/layers/+haskell.el -*- lexical-binding: t; -*-


(remove-hook! 'haskell-mode-hook #'interactive-haskell-mode)
(add-hook! 'haskell-mode-hook #'rainbow-delimiters-mode)


(setq haskell-compile-ignore-cabal t
      haskell-stylish-on-save t)

(set-repl-handler! 'haskell-mode #'switch-to-haskell)

(map! :map* haskell-mode-map
      :localleader
      :desc "Refactor buffer" :n "l" #'hlint-refactor-refactor-buffer
      :desc "Refactor at cursor" :n "h" #'hlint-refactor-refactor-at-point)

(when (featurep! :lang haskell +intero)
  (def-package! intero
    :config
    (setq intero-extra-ghci-options "-XNoImplicitPrelude")))

(when (featurep! :lang haskell +dante)
  (def-package! dante
    :init
    (setq haskell-compile-cabal-build-command "stack build --fast")))


(when (not (or (featurep! :lang haskell +intero)
               (featurep! :lang haskell +dante)))
  (def-package! lsp-haskell
    :hook (haskell-mode . lsp-haskell-enable)
    :config
    (lsp-haskell-set-completition-snippets t)))
