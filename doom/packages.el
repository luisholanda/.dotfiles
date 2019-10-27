(package! vue-mode)
(package! emmet-mode)
(package! git-gutter-fringe)
(package! golden-ratio)
(package! dockerfile-mode)
(package! focus)
(package! ace-jump-mode)
(package! sublimity)

;; Async company backend for files
(package! company-async-files
  :recipe (:host github
                    :repo "CeleritasCelery/company-async-files"
                    :files ("company-async-files.el")))
