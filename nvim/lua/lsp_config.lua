local nvim_lsp = nil;
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

local function lsp_on_attach(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  vim.api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')

  M.update_completion_kinds()

  diagnostics.on_attach()
end

local function rust_analyzer_cmd()
  local fh = assert(io.popen("rustup which rust-analyzer"))
  local data = fh:read("*a")
  fh:close()
  return data:sub(1, -2)
end

function M.setup()
  nvim_lsp = require('nvim_lsp')
  diagnostics = require('diagnostic')
  protocol = require('vim.lsp.protocol')

  nvim_lsp.rust_analyzer.setup{
    cmd = {rust_analyzer_cmd()},
    log_level = vim.lsp.protocol.MessageType.Log,
    message_level = vim.lsp.protocol.MessageType.Log,
    on_attach = lsp_on_attach,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
        },
        completion = {
          postfix = { enable = true },
        },
        inlayHints = { enable = true },
        procMacro = { enable = true },
      }
    }
  }

  nvim_lsp.bashls.setup{on_attach = lsp_on_attach}
  nvim_lsp.vimls.setup{on_attach = lsp_on_attach}
  nvim_lsp.pyls_ms.setup{on_attach = lsp_on_attach}
  nvim_lsp.tsserver.setup{on_attach = lsp_on_attach}
  require('nlua.lsp.nvim').setup(nvim_lsp, { on_attach = lsp_on_attach })
end

return M
