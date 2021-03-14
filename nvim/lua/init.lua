require('config')
require('plugins')

require('gitsigns').setup {
  numhl = false,
  signs = {
    add          = {text = '┃', hl='GitGutterAdd'},
    change       = {text = '┃', hl='GitGutterChange'},
    delete       = {text = '◢', hl='GitGutterDelete'},
    topdelete    = {text = '◥', hl='GitGutterDelete'},
    changedelete = {text = '◢', hl='GitGutterChangeDelete'},
  }
}

require("zephyr")
require("colorizer").setup()
require("lsp/config").setup()
require("lsp/saga").setup()
