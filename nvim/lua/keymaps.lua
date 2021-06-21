local wk = require("which-key")

local IGNORE = "which_key_ignore"

local _maps = {}

local function nmap(map, expr, name, opts)
  opts = opts or {}
  _maps[map] = vim.tbl_extend("keep", { expr or IGNORE, name }, opts)
end

local function vmap(map, expr, name, opts)
  opts = opts or {}
  opts["mode"] = "v"
  nmap(map, name, expr, opts)
end

local function imap(map, expr, name, opts)
  opts = opts or {}
  opts["mode"] = "i"
  nmap(map, name, expr, opts)
end

local function group(prefix, name, mappings)
  mappings["name"] = name
  _maps[prefix] = mappings
end

local function leader_group(prefix, name, mappings)
  group("<leader>" .. prefix, name, mappings)
end

leader_group("b", "Buffer", {
  w = { "<cmd>update<CR>", "Save" },
  d = { "<cmd>Bclose<CR>", "Close" },
  D = { "<cmd>Bclose!<CR>", "Force close" },
  p = { "<cmd>bp<CR>", "Previous" },
  n = { "<cmd>bn<CR>", "Next" },
})

leader_group("w", "Window", {
  s = { "<cmd>rightbelow split<CR>", "Horizontal split" },
  v = { "<cmd>rightbelow vsplit<CR>", "Vertical split" },
  l = { "<cmd>wincmd l<CR>", "Go to window on the right" },
  h = { "<cmd>wincmd h<CR>", "Go to window on the left" },
  k = { "<cmd>wincmd k<CR>", "Go to window on the top" },
  j = { "<cmd>wincmd j<CR>", "Go to window on the bottom" },
  q = { "<cmd>wincmd c<CR>", "Close window" },
})

leader_group("s", "Search", {
  f = { require("telescope.builtin").find_files, "Files" },
  g = { require("telescope.builtin").live_grep, "Grep" },
  b = { require("telescope.builtin").buffers, "Buffers" },
})

leader_group("l", "LSP", {
  h = { require("lspsaga.provider").lsp_finder, "Definitions/References" },
  D = { require("lspsaga.provider").preview_definition, "Preview definition" },
  f = { vim.lsp.buf.formatting, "Format document" },
  a = { require("lspsaga.codeaction").code_action, "Code actions" },
  r = { require("lspsaga.rename").rename, "Rename symbol" },
})

leader_group("ld", "LSP diagnostics", {
  t = { "<cmd>Trouble<cr>", "Toggle diagnostics" },
  f = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Toggle file diagnostics" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Toggle workspace diagnostics" },
  l = { "<cmd>Trouble loclist<cr>", "Loclist diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "Quickfix diagnostics" },
})

group("g", "Go to", {
  d = { vim.lsp.buf.definition, "Definition" },
  D = { vim.lsp.buf.declaration, "Declaration" },
  i = { vim.lsp.buf.implementation, "Implementation" },
  I = { vim.lsp.buf.incoming_calls, "Incoming calls" },
  ["~"] = IGNORE,
  u = IGNORE,
  U = IGNORE,
})

group("[", "Previous", {
  c = { "Git Chunk" },
  d = { require("lspsaga.diagnostic").lsp_jump_diagnostic_prev, "Diagnostic" }
})

group("]", "Next", {
  c = { "Git Chunk" },
  d = { require("lspsaga.diagnostic").lsp_jump_diagnostic_next, "Diagnostic" }
})

-- Because I'm dumb
nmap(":w<CR>", "<cmd>up<CR>")
nmap(":W<CR>", "<cmd>up<CR>")
nmap(":Q<CR>", "<cmd>q<CR>")
nmap(":WQ<CR>", "<cmd>wq<CR>")
nmap(":wQ<CR>", "<cmd>wq<CR>")
nmap(":Wq<CR>", "<cmd>wq<CR>")

-- Better hover integration with lspsaga
nmap("<C-f>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', "Scroll forward")
nmap("<C-b>", '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', "Scroll backward")

nmap("Y", "y$", "Copy till end of line")
nmap("K", require("lspsaga.hover").render_hover_doc, "Hover")
nmap("<tab>", "<cmd>wincmd w<CR>", "Cycle windows")
nmap("<leader>q", "<cmd>q<CR>", "Quit")
nmap("<CR><CR>", "<c-^>", "Quick previous buffer")

vmap("<leader>la", require("lspsaga.codeaction").range_code_action, "Code actions")

imap("<up>", "<nop>")
imap("<down>", "<nop>")
imap("<C-k>", require("lspsaga.signaturehelp").signature_help, "Signature help")

local operators = {
  ["<M-n>"] = nil,
  ["<M-p>"] = nil,
  ["@"] = nil,
  z = nil,
  Z = nil,
  ["<CR>"] = "Tree-sitter node",
  a = { name = "Around" },
  A = { name = "Around trimmed" },
  i = { name = "Inside" },
  I = { name = "Inside trimmed" },
  ["["] = { name = "Previous" },
  ["]"] = { name = "Next" },
  -- vim-surround
  s = { name = "Surround" },
  S = { name = "Surround with spaces" },
  -- gitsigns
  ["ih"] = "Git chunk",
}

wk.setup{
  plugins = {
    spelling = {
      enabled = true,
    },
  },
  operators = operators,
  key_labels = {
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB"
  },
}

wk.register(_maps)
