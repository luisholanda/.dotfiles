local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')
local completion = require('completion')
local diagnostics = require('diagnostic')
local protocol = require('vim.lsp.protocol')

local function update_completion_kinds()
  protocol.CompletionItemKind = {
    '';
    '';
    'ƒ';
    '';
    '料';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '';
    '渚';
    '';
    '';
    '';
    'פּ';
    '鬒';
    'Ψ';
    '';
  }
end


local lsp_on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')

  update_completion_kinds()

  diagnostics.on_attach()
  completion.on_attach()
end

local function rust_analyzer_cmd()
  local fh = assert(io.popen("rustup which rust-analyzer"))
  local data = fh:read("*a")
  fh:close()
  return data:sub(1, -2)
end

nvim_lsp.rust_analyzer.setup{
  cmd = {rust_analyzer_cmd()},
  log_level = vim.lsp.protocol.MessageType.Log,
  message_level = vim.lsp.protocol.MessageType.Log,
  on_attach = lsp_on_attach
}

nvim_lsp.bashls.setup{on_attach = lsp_on_attach}
nvim_lsp.vimls.setup{on_attach = lsp_on_attach}
nvim_lsp.pyls_ms.setup{on_attach = lsp_on_attach}
nvim_lsp.tsserver.setup{on_attach = lsp_on_attach}
nvim_lsp.sumneko_lua.setup{on_attach = lsp_on_attach}

