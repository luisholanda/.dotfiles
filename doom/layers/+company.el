;;; ~/.config/doom/+company.el -*- lexical-binding: t; -*-

;; Configure Company related things.

(push 'company-async-files company-backends)
(setq company-idle-delay 0.1
      company-minimum-prefix-length 3
      company-box-doc-delay 0.1)


(def-package! company-box
  :hook (company-mode . company-box-mode))
