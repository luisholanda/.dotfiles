source ~/.dotfiles/nvim/essentials.vim
source ~/.dotfiles/nvim/plugins.vim
source ~/.dotfiles/nvim/fzf.vim
source ~/.dotfiles/nvim/keymaps.vim
source ~/.dotfiles/nvim/status-line.vim

syntax enable
filetype plugin indent on

let g:srcery_italic = 1
colorscheme srcery

command! -bang -complete=buffer -nargs=? Bclose call bclose#close_buffer(<q-bang>, <q-args>)
autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType help wincmd L
