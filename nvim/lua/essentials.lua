local o = vim.o or {}

o.shell = "/usr/local/bin/fish"
vim.api.nvim_command('let mapleader=";"')

vim.g.loaded_python_provider = 0
vim.g.python3_host_prog = vim.fn.expand("~/.pyenv/versions/neovim/bin/python")
o.pyxversion = 3

o.number = true
o.cursorline = true
o.colorcolumn = "+0,+10"

-- Always show tabline
o.showtabline = 2
-- Never show statusline on the last window
o.laststatus = 0

-- number of lines at the beginning and end of files checked for file-specific vars
o.modelines = 0


-- time waited for key press(es) to complete. It makes for a faster key response.
o.ttimeout = true
o.ttimeoutlen = 2

-- reload files changed outside of Vim not currently modified in Vim (needs below)
o.autoread = true
vim.api.nvim_command("autocmd FocusGained,BufEnter * checktime")

-- make Backspace work like Delete
o.backspace = "indent,eol,start"

-- don't create `filename~` backups
o.backup = false

-- c: don't give |ins-completion-menu| messages.
-- F: don't show statusline in unfocused buffers.
o.shortmess = vim.o.shortmess .. 'cF'

-- number of lines offset when jumping
o.scrolloff = 2
o.sidescrolloff = 5

-- Tab key enters 2 spaces
-- To enter a TAB character when 'expandtab' is in effect, CTRL-v-TAB.
o.expandtab   = true
o.tabstop     = 2
o.shiftwidth  = 2
o.softtabstop = o.tabstop

-- Indent new line the same as the preceding line
o.autoindent = true

-- make scrolling and painting fast.
o.lazyredraw = true

-- update changes faster.
o.updatetime = 100

-- Better behaviour from autocomplete pop-up.
o.completeopt = "noinsert,menu,noselect"
o.pumheight   = 25

-- highlight matching parenthesis, braces, brackets, etc.
o.showmatch = true

-- http://vim.wikia.com/wiki/Searching
o.incsearch = true
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

-- open new buffers without saving current modifications (buffer remains open).
o.hidden = true

-- http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
o.wildmenu = true
o.wildmode = "list:longest,full"
o.wildignore = vim.o.wildignore .. "vendor/**,node_modules/**,target/**"

o.foldmethod = "syntax"
o.foldenable = false

o.signcolumn = "yes:2"
o.synmaxcol = 240

vim.g.clipboard = {
  name = "pbcopy",
  copy = {
    ["+"] = "pbcopy",
    ["*"] = "pbcopy",
  },
  paste = {
    ["+"] = "pbpaste",
    ["*"] = "pbpaste",
  },
  cache_enabled = 1
}
o.clipboard = "unnamedplus"

o.termguicolors = true

-- Configure undo history
o.undofile = true
o.undodir = vim.env.HOME .. "/.local/share/nvim/vimundo"
o.undolevels = 1000
o.undoreload = 10000

o.ruler = true
