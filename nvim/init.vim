set shell=/bin/zsh
syntax enable
filetype plugin indent on

" Basic VIM configuration
" drop vi support - kept for vim compatibility but not needed for nvim
set nocompatible

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" errors flash screen rather than emit beep
set visualbell

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
set relativenumber
set number

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Indent new line the same as the preceding line
set autoindent

" statusline indicates insert or normal mode
set showmode showcmd

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set ttyfast lazyredraw

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full
set wildignore+=vendor/**
set wildignore+=node_modules/**
set wildignore+=target/**

set foldmethod=indent
set nofoldenable

" StatusLine always visible, display full path
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
set laststatus=2 statusline=%F

" Use system clipboard
" http://vim.wikia.com/wiki/Accessing_the_system_clipboard
set clipboard=unnamedplus

" Show character column
highlight ColorColumn ctermbg=DarkBlue
set colorcolumn=80

" CursorLine - sometimes autocmds are not performant; turn off if so
" http://vim.wikia.com/wiki/Highlight_current_line
set cursorline
" Normal mode
highlight CursorLine ctermbg=None
autocmd InsertEnter * highlight  CursorLine ctermbg=17 ctermfg=None
autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Guarantee that vim-plug is installed
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Spacegray ColorScheme
Plug 'ajh17/spacegray.vim'

Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': { -> coc#util#install()} }

Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'matze/vim-move'
Plug 'ap/vim-buftabline'
Plug 'justincampbell/vim-eighties'
Plug 'mattn/emmet-vim'
Plug 'Shougo/echodoc.vim'
Plug 'rhysd/devdocs.vim'
Plug 'myusuf3/numbers.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'felikZ/ctrlp-py-matcher'

Plug 'neovim/node-host', { 'do': 'npm install' }
Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }

call plug#end()

noremap <leader>ws :rightbelow split<CR>
noremap <leader>wv :rightbelow vsplit<CR>
noremap <leader>wh :wincmd h<CR>
noremap <leader>wj :wincmd j<CR>
noremap <leader>wk :wincmd k<CR>
noremap <leader>wl :wincmd l<CR>
noremap <leader>ww :wincmd w<CR>
noremap <leader>wq :wincmd c<CR>

noremap <leader>bn :bnext<CR>
noremap <leader>bp :bprev<CR>
noremap <leader>bd :Bclose<CR>
noremap <leader>bs :new<CR>
noremap <leader>bv :vnew<CR>
noremap <leader>bc :enew<CR>

noremap <leader>d <Plug>(devdocs-under-cursor)

tmap <ESC> <C-\><C-n>

noremap <leader>ft :NERDTreeToggle<CR>

let g:spacegray_use_italics = 1
let g:spacegray_low_contrast = 1

colorscheme spacegray

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

autocmd FileType ts,tsx,js,jsx :TrigisStart

let g:trigis#on_the_fly_enabled = 1
let g:trigis#delay = 500

" GitGutter things
let g:gitgutter_map_keys = 0

" CtrlP things
nmap <leader>sf :CtrlP<CR>
nmap <leader>sb :CtrlPBuffer<CR>

" EasyMotion things
let g:EasyMotion_do_mapping = 1

" lightline thigs
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'one',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'cocstatus', 'readonly', 'filename', 'modified']]
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" coc.nvim things

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" dont give |ins-completion-menu| messages.
set shortmess+=c

" alway show signcolumns
set signcolumn=yes

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col-1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr><cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

nmap <silent> [c <Plug>(coc-definition-prev)
nmap <silent> [c <Plug>(coc-definition-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)

vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup cocgroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

nmap <leader>c <Plug>(coc-codeaction)
nmap <leader>qf <plug>(coc-fix-current)

command! -nargs=0 Format :call CocAction('format')

command! -nargs=? Fold :call CocAction('fold', <f-args>)

nnoremap <silent> <space>a :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c :<C-u>CocList commands<cr>
nnoremap <silent> <space>o :<C-u>CocList outline<cr>
nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>j :<C-u>CocNext<cr>
nnoremap <silent> <space>k :<C-u>CocPrev<cr>
nnoremap <silent> <space>p :<C-u>CocListResume<cr>

if has('autocmd')
  function! ILikeHelpToTheRight()
    if !exists('w:help_is_moved') || w:help_is_moved != "right"
      wincmd L
      let w:help_is_moved = "right"
    endif
  endfunction

  augroup HelpPages
    autocmd FileType help nested call ILikeHelpToTheRight()
  augroup END
endif


" Delete buffer while keeping window layout (don't close buffer's windows).
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != btarget
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'Startify'
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose(<q-bang>, <q-args>)

set conceallevel=2

autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_0\ze_?>', 10, -1, {'conceal': '₀'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_1\ze_?>', 10, -1, {'conceal': '₁'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_2\ze_?>', 10, -1, {'conceal': '₂'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_3\ze_?>', 10, -1, {'conceal': '₃'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_4\ze_?>', 10, -1, {'conceal': '₄'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_5\ze_?>', 10, -1, {'conceal': '₅'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_6\ze_?>', 10, -1, {'conceal': '₆'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_7\ze_?>', 10, -1, {'conceal': '₇'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_8\ze_?>', 10, -1, {'conceal': '₈'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_9\ze_?>', 10, -1, {'conceal': '₉'})

autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_0\ze_?>', 10, -1, {'conceal': '₀'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_1\ze_?>', 10, -1, {'conceal': '₁'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_2\ze_?>', 10, -1, {'conceal': '₂'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_3\ze_?>', 10, -1, {'conceal': '₃'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_4\ze_?>', 10, -1, {'conceal': '₄'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_5\ze_?>', 10, -1, {'conceal': '₅'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_6\ze_?>', 10, -1, {'conceal': '₆'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_7\ze_?>', 10, -1, {'conceal': '₇'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_8\ze_?>', 10, -1, {'conceal': '₈'})
autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v<[[:alpha:]_]+\zs_9\ze_?>', 10, -1, {'conceal': '₉'})

autocmd BufReadPre,FileReadPre * call matchadd('Conceal', '\v[^_ ]\zs_\ze>', 10, -1, {'conceal': '′'})

inoremap <BS> <Nop>
inoremap <Del> <Nop>

autocmd BufWritePre * %s/\s\+$//e
