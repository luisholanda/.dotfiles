source ~/.dotfiles/nvim/essentials.vim
source ~/.dotfiles/nvim/plugins.vim
source ~/.dotfiles/nvim/fzf.vim
source ~/.dotfiles/nvim/keymaps.vim

syntax enable
filetype plugin indent on

set background=dark
colorscheme snow

if dein#tap('Shougo/echodoc.vim')
  let g:echodoc_enable_at_startup = 1
  let g:echodoc#type = 'virtual'
endif

command! -bang -complete=buffer -nargs=? Bclose call bclose#close_buffer(<q-bang>, <q-args>)
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType help wincmd L
