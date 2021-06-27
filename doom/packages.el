;; -*- no-byte-compile: t; -*-
;;; ~/.config/doom/packages.el
(package! color-identifiers-mode :disable t)
(package! git-gutter-fringe)
(package! focus)

;; Ace Jump
(package! ace-jump-mode
  :recipe (:host github
                 :repo "winterTTr/ace-jump-mode"
                 :files ("ace-jump-mode.el")))

(package! tsc
  :recipe (:host github
                 :repo "ubolonton/emacs-tree-sitter"
                 :files ("core/*.el")))

(package! tree-sitter
  :recipe (:host github
           :repo "ubolonton/emacs-tree-sitter"
           :files ("lisp/*.el")))

(package! tree-sitter-langs
  :recipe (:host github
           :repo "ubolonton/emacs-tree-sitter"
           :files ("langs/*.el" "langs/queries")))

(package! parinfer-rust-mode
  :recipe (:host github
           :repo "justinbarclay/parinfer-rust-mode"
           :files ("*.el")))

(package! exec-path-from-shell
  :recipe (:host github
           :repo "purcell/exec-path-from-shell"
           :files ("*.el")))
