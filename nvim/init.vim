source ~/.dotfiles/nvim/essentials.vim
source ~/.dotfiles/nvim/plugins.vim
source ~/.dotfiles/nvim/bclose.vim
source ~/.dotfiles/nvim/coc.vim
source ~/.dotfiles/nvim/keymaps.vim

syntax enable
filetype plugin indent on


" autocmd ColorScheme jana highlight Normal ctermbg=235
colorscheme janah
" colorscheme space_vim_theme
" let g:seoul256_backgroud = 235
" let g:seoul256_srgb = 1
" colorscheme seoul256

autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

let g:deoplete#enable_at_startup = 1

" GitGutter things
let g:gitgutter_map_keys = 0

" Better glyphs
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'
let g:gitgutter_override_sign_column_highlight = 0

" Removing background for a e s t h e t i c s
hi! GitGutterAdd ctermbg=NONE guibg=NONE
hi! GitGutterChange ctermbg=NONE guibg=NONE
hi! GitGutterDelete ctermbg=NONE guibg=NONE
hi! GitGutterChangeDelete ctermbg=NONE guibg=NONE

" Update changes faster
set updatetime=100

" Better behaviour from autocomplete popup
set completeopt=noinsert,menuone,noselect

"- Startify -"
let g:startify_custom_header = [
            \ '',
            \ '',
            \ '',
            \ '   ███╗   ██╗    ███████╗     ██████╗     ██╗   ██╗    ██╗    ███╗   ███╗' ,
            \ '   ████╗  ██║    ██╔════╝    ██╔═══██╗    ██║   ██║    ██║    ████╗ ████║' ,
            \ '   ██╔██╗ ██║    █████╗      ██║   ██║    ██║   ██║    ██║    ██╔████╔██║' ,
            \ '   ██║╚██╗██║    ██╔══╝      ██║   ██║    ╚██╗ ██╔╝    ██║    ██║╚██╔╝██║' ,
            \ '   ██║ ╚████║    ███████╗    ╚██████╔╝     ╚████╔╝     ██║    ██║ ╚═╝ ██║' ,
            \ '   ╚═╝  ╚═══╝    ╚══════╝     ╚═════╝       ╚═══╝      ╚═╝    ╚═╝     ╚═╝' ,
            \ ]

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, extend(fzf#vim#with_preview(), { 'source': 'rg --files' }), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

nmap <leader>sf :Files<CR>
nmap <leader>sb :Buffers<CR>
nmap <leader>sg :Rg<CR>
nmap <leader>sc :noh<CR>

let g:fzf_layout = { 'down': '~20%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" EasyMotion things
let g:EasyMotion_do_mapping = 1

" lightline thigs
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 0
  \ },
  \ 'active': {
  \   'left':  [ [ 'mode', 'paste' ],
  \              [ 'cocstatus' ],
  \              [ 'gitbranch' ],
  \              [ 'filename', 'readonly', 'modified']],
  \   'right': [ ['lineinfo', 'backjobs'],
  \              ['percent'],
  \              ['filetype']]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status',
  \   'gitbranch': 'LightlineGitBranch',
  \   'readonly': 'LightlineReadonly',
  \   'backjobs': 'BackgroundJobs',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineGitBranch()
  if exists('*fugitive#head')
    let branch = fugitive#head(8)
    if branch !=# ''
      return ' '.branch
    endif
  endif
  return ''
endfunction

function! BackgroundJobs()
  if !exists('g:asyncrun_status')
    return ''
  elseif g:asyncrun_status == 'running'
    return 'running'
  elseif g:asyncrun_status == 'failure'
    return 'failed'
  else
    return ''
  endif
endfunction

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType help wincmd L

" Vimade things
let g:vimade = {}
let g:vimade.enablesigns = 1

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
