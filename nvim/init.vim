source ~/.dotfiles/nvim/essentials.vim
source ~/.dotfiles/nvim/plugins.vim
source ~/.dotfiles/nvim/bclose.vim
source ~/.dotfiles/nvim/coc.vim
source ~/.dotfiles/nvim/fzf.vim
source ~/.dotfiles/nvim/keymaps.vim
source ~/.dotfiles/nvim/status-line.vim

syntax enable
filetype plugin indent on

let g:srcery_italic = 1
colorscheme srcery

autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

" GitGutter things
let g:gitgutter_map_keys = 0

" Better glyphs
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
let g:gitgutter_override_sign_column_highlight = 0

let g:indentLine_char = '▏'

" Update changes faster
set updatetime=100

" Better behaviour from autocomplete popup
set completeopt=noinsert,menuone,noselect

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType help wincmd L

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

let g:asyncrun_open = 14

let g:rustfmt_command = 'cargo fmt'
let g:rustfmt_autosave = 1

au FileType plantuml let g:plantuml_previewer#plantuml_jar_path = get(
    \  matchlist(system('cat `which plantuml` | grep plantuml.jar'),
    \            '\v.*\s[''"]?(\S+plantuml\.jar).*'),
    \  1,
    \  0
    \)
