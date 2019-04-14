;; -*- no-byte-compile: t; -*-
;;; ~/.config/doom/packages.el

(packages! color-identifiers-mode
           vue-mode
           emmet-mode
           git-gutter-fringe
           golden-ratio
           focus)

(when (and (featurep! :lang python)
           (not (featurep! :lang python conda)))
  (package! elpy))

;; LSP things
;;(package! eglot)
(packages! lsp-mode lsp-ui company-lsp)

(package! lsp-haskell)


;; Ace Jump
(package! ace-jump-mode
  :recipe (:fetcher github
                    :repo "winterTTr/ace-jump-mode"
                    :files ("ace-jump-mode.el")))

;; Async company backend for files
(package! company-async-files
  :recipe (:fetcher github
                    :repo "CeleritasCelery/company-async-files"
                    :files ("company-async-files.el")))


(package! company-box
  :recipe (:fetcher github
                    :repo "jsmestad/company-box"
                    :branch "patch-1"
                    :files ("*.el")))

(package! dockerfile-mode)


(package! evil-matchit 
  :recipe (:fetcher github 
                    :repo "redguardtoo/evil-matchit" 
                    :commit "7d65b4167b1f0086c2b42b3aec805e47a0d355c4"))
