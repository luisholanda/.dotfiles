(when (featurep! :lang rust +lsp)
  (when (executable-find "ra_lsp_server")
    (setq rustic-lsp-server 'rust-analyzer)))
