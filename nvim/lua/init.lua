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

