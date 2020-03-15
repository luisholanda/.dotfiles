local nvim_lsp = require'nvim_lsp'
local completion = require'completion'
local diagnostics = require'diagnostic'

local function lsp_on_attach(client)
  completion.on_attach(client)
  diagnostics.on_attach(client)
end

nvim_lsp.rust_analyzer.setup{on_attach=lsp_on_attach}
nvim_lsp.bashls.setup{on_attach=lsp_on_attach}
nvim_lsp.vimls.setup{on_attach=lsp_on_attach}
nvim_lsp.pyls_ms.setup{on_attach=lsp_on_attach}
nvim_lsp.tsserver.setup{on_attach=lsp_on_attach}
nvim_lsp.sumneko_lua.setup{on_attach=lsp_on_attach}


