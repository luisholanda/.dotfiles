set shell=/usr/local/bin/fish
let mapleader=";"


let g:loaded_python_provider = 0
let g:python3_host_prog = expand("~/.pyenv/versions/neovim/bin/python")
set pyxversion=3

set number
set cursorline
set colorcolumn=+0,+10

" Show tabline
set showtabline=2

" number of lines at the beginning and end of files checked for file-specific vars
set modelines=0

" time waited for key press(es) to complete. It makes for a faster key response.
set ttimeout
set ttimeoutlen=5

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
autocmd FocusGained,BufEnter * checktime

" make Backspace work like Delete
set backspace=indent,eol,start

" don't create `filename~` backups
set nobackup

" don't give |ins-completion-menu| messages.
set shortmess+=c
" don't show statusline in unfocused buffers
set shortmess+=F

" number of lines offset when jumping
set scrolloff=2

" Tab key enters 2 spaces
" To enter a TAB character when `expandtab` is in effect,
" CTRL-v-TAB
set expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Indent new line the same as the preceding line
set autoindent

" make scrolling and painting fast
" ttyfast kept for vim compatibility but not needed for nvim
set lazyredraw

" Update changes faster
set updatetime=100

" Better behaviour from autocomplete popup
set completeopt=noinsert,menuone,noselect
set pumheight=25

" highlight matching parens, braces, brackets, etc
set showmatch

" http://vim.wikia.com/wiki/Searching
set incsearch ignorecase smartcase

" open new buffers without saving current modifications (buffer remains open)
set hidden

" http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set wildmenu wildmode=list:longest,full
set wildignore+=vendor/**
set wildignore+=node_modules/**
set wildignore+=target/**

set foldmethod=syntax
set nofoldenable

" Only show sign column when needed.
set signcolumn=auto:2

set synmaxcol=240

" Use system clipboard
let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 1,
  \ }
set clipboard=unnamedplus

" Always show at least two lines below/above the cursor
if !&scrolloff
  set scrolloff=2
endif
if !&sidescrolloff
  set sidescrolloff=5
endif

" Don't show mode in cmdline
set noshowmode

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if has("nvim")
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if has("termguicolors")
  set termguicolors
endif

" Configure undo history
set undofile
set undodir=$HOME/.vimundo
set undolevels=1000
set undoreload=10000
