local nvim_lsp = nil;
local lsp_status = nil;
local diagnostics = nil;
local protocol = nil;

local M = {}

function M.update_completion_kinds()
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

local function lsp_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')

  M.update_completion_kinds()

  diagnostics.on_attach(client, bufnr)
  lsp_status.on_attach(client, bufnr)
end

local function rust_analyzer_cmd()
  local fh = assert(io.popen("rustup which rust-analyzer"))
  local data = fh:read("*a")
  fh:close()
  return data:sub(1, -2)
end

function M.setup()
  nvim_lsp = require('nvim_lsp')
  lsp_status = require('lsp-status')
  diagnostics = require('diagnostic')
  protocol = require('vim.lsp.protocol')

  lsp_status.register_progress()

  nvim_lsp.rust_analyzer.setup{
    cmd = {rust_analyzer_cmd()},
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          noDefaultFeatures = false,
        },
        checkOnSave = {
          allFeatures = true,
        },
        completion = {
          addCallArgumentSnippets = false,
          postfix = { enable = false },
        },
        inlayHints = { enable = false },
      }
    }
  }

  nvim_lsp.bashls.setup{
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
  }
  nvim_lsp.vimls.setup{
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
  }
  nvim_lsp.pyls_ms.setup{
    callbacks = lsp_status.extensions.pyls_ms.setup(),
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
    setup = { python = { workspaceSymbols = { enable = true } } },
  }
  nvim_lsp.tsserver.setup{
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
  }
  require('nlua.lsp.nvim').setup(nvim_lsp, {
    on_attach = lsp_on_attach,
    capabilities = lsp_status.capabilities,
  })
end

return M
