;;; ~/.config/doom/+lsp-mode.el -*- lexical-binding: t; -*-
(def-package! lsp-mode
  :commands (lsp-mode lsp-define-stdio-client)
  :init
  (setq lsp-enable-flycheck nil))


(def-package! lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (set-lookup-handlers! 'lsp-ui-mode
    :definition #'lsp-ui-peek-find-definitions
    :references #'lsp-ui-peek-find-references)
  (setq lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-max-height 8
        lsp-ui-doc-max-width 35))


(def-package! company-lsp
  :config
  (set-company-backend! 'lsp-mode 'company-lsp)
  (setq company-lsp-enable-recompletion t
        company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))
