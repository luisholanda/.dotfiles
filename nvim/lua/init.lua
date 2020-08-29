require('plugins')

vim.g.completion_chain_complete_list = {
  default = {
    { complete_items = {"lsp", "tabnine"} },
    { mode = '<c-p>' },
    { mode = '<c-n>' },
  }
}

