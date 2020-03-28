;; -*- no-byte-compile: t; -*-
;;; ~/.config/doom/packages.el

(package! color-identifiers-mode)
(package! git-gutter-fringe)
(package! golden-ratio)
(package! focus)

;; Ace Jump
(package! ace-jump-mode
  :recipe (:host github
                 :repo "winterTTr/ace-jump-mode"
                 :files ("ace-jump-mode.el")))
