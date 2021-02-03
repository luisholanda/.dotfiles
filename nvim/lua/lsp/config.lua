local nvim_lsp = nil;
local lsp_status = nil;
local completion = nil;
--local diagnostics = nil;
local protocol = nil;
local lsputil = nil;

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

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  completion.on_attach(client, bufnr)
  --lsp_status.on_attach(client, bufnr)
end

local function configure_servers()
  nvim_lsp.util.default_config.capabilities = vim.tbl_deep_extend("keep", nvim_lsp.util.default_config.capabilities or {}, lsp_status.capabilities)
  nvim_lsp.rust_analyzer.setup{
    root_dir = nvim_lsp.util.root_pattern("Cargo.lock", "rust-project.json"),
    cmd = {"rust-analyzer"},
    on_attach = lsp_on_attach,
    init_options = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
      },
      checkOnSave = {
        allFeatures = true,
      },
      completion = {
        addCallArgumentSnippets = false,
        postfix = { enable = false },
      },
      procMacro = { enable = true },
    }
  }

  nvim_lsp.bashls.setup{
    on_attach = lsp_on_attach,
  }
  nvim_lsp.ccls.setup{
    on_attach = lsp_on_attach,
  }
  nvim_lsp.cmake.setup{
    on_attach = lsp_on_attach,
  }
  nvim_lsp.vimls.setup{
    on_attach = lsp_on_attach,
  }
  nvim_lsp.pyright.setup{
    on_attach = lsp_on_attach,
    root_dir = nvim_lsp.util.root_pattern(".git"),
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = "strict",
        },
        pythonPath = vim.fn.exepath("python"),
        venvPath = "/Users/luiscm/.pyenv/versions"
      }
    }
  }
  nvim_lsp.tsserver.setup{
    on_attach = lsp_on_attach,
  }
  nvim_lsp.rnix.setup {
    on_attach = lsp_on_attach,
  }
end

-- for rust-analyzer. Fixed https://github.com/rust-analyzer/rust-analyzer/issues/4901
local function rename_rust_analyzer_4901_fixed(_err, _method, result)
  if not result then return end
  if result.documentChanges then
    local merged_changes = {}
    local versions = {}

    for _, change in ipairs(result.documentChanges) do
      if change.kind then
        error("not support")
      else
        local edits = merged_changes[change.textDocument.uri] or {}
        versions[change.textDocument.uri] = change.textDocument.version
        for _, edit in ipairs(change.edits) do
          table.insert(edits, edit)
        end
        merged_changes[change.textDocument.uri] = edits
      end
    end

    local new_changes = {}
    for uri, edits in pairs(merged_changes) do
      table.insert(new_changes, {
        edits = edits,
        textDocument = {
          uri = uri,
          version = versions[uri]
        }
      })
    end
    result.documentChanges = new_changes
  end

  vim.lsp.util.apply_workspace_edit(result)
end

local function setup_callbacks()
  vim.lsp.callbacks["textDocument/codeAction"] = lsputil.codeAction.code_action_handler
  vim.lsp.callbacks["textDocument/references"] = lsputil.locations.references_handler
  vim.lsp.callbacks["textDocument/definition"] = lsputil.locations.definition_handler
  vim.lsp.callbacks["textDocument/declaration"] = lsputil.locations.declaration_handler
  vim.lsp.callbacks["textDocument/typeDefinition"] = lsputil.locations.typeDefinition_handler
  vim.lsp.callbacks["textDocument/implementation"] = lsputil.locations.implementation_handler
  vim.lsp.callbacks["textDocument/documentSymbol"] = lsputil.locations.document_handler
  vim.lsp.callbacks["textDocument/rename"] = rename_rust_analyzer_4901_fixed
  vim.lsp.callbacks["workspace/symbol"] = lsputil.symbols.workspace_handler
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      signs = true,
      virtual_text = true,
      underline = true,
      update_in_insert = false,
  })
end

function M.setup()
  nvim_lsp = require('lspconfig')
  lsp_status = require('lsp-status')
  completion = require('completion')
  protocol = require('vim.lsp.protocol')
  lsputil = {
    codeAction = require('lsputil.codeAction'),
    locations = require('lsputil.locations'),
    symbols = require('lsputil.symbols')
  }

  M.update_completion_kinds()

  -- lsp_status.register_progress()
  setup_callbacks()
  configure_servers()
end

return M
