set runtimepath+=~/.local/share/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/nvim/dein')
  call dein#begin('~/.local/share/nvim/dein')

  call dein#add('Shougo/dein.vim')

  call dein#add('romainl/vim-cool')

  call dein#add('triglav/vim-visual-increment', { 'on_map': '<Plug>' })

  call dein#add('jiangmiao/auto-pairs')

  call dein#add('airblade/vim-rooter')
  call dein#add('skywind3000/asyncrun.vim', {
        \ 'on_cmd': 'AsyncRun',
        \ 'hook_source': 'let g:asyncrun_open = 14',
        \ })
  call dein#add('Shougo/deol.nvim', { 'on_cmd': ['Deol', 'DeolCd', 'DeolEdit'] })

  call dein#add('nightsense/snow')

  call dein#add('Yggdroot/indentLine', { 'hook_add': 'let g:indentLine_char="▏"' })
  call dein#add('rbong/vim-crystalline', {
        \ 'on_event': 'UIEnter',
        \ 'hook_source': 'call hooks#plugins#crystalline()'
        \ })

  call dein#add('neoclide/coc.nvim', {
        \ 'build': 'yarn install',
        \ 'on_ft': ['vim', 'rust', 'python', 'json'],
        \ 'hook_source': 'source /Users/luiscm/.dotfiles/nvim/coc.vim'
        \ })
  call dein#add('Shougo/echodoc.vim')

  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-surround')
  call dein#add('easymotion/vim-easymotion', {
        \ 'on_map': '<Plug>',
        \ 'hook_source': 'call hooks#plugins#easymotion()'
        \ })

  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter', {
        \ 'on_event': 'BufWinEnter',
        \ 'hook_source': 'call hooks#plugins#gitgutter()',
        \ })
  call dein#add('sodapopcan/vim-twiggy', { 'on_cmd': 'Twiggy' })
  call dein#add('junegunn/gv.vim', { 'on_cmd': 'GV' })
  call dein#add('terryma/vim-expand-region', { 'on_map':  '<Plug>' })

  call dein#add('wellle/targets.vim')
  call dein#add('gcmt/wildfire.vim', { 'on_map': '<Plug>' })

  call dein#add('rust-lang/rust.vim', {
        \ 'on_ft': 'rust',
        \ 'hook_source': 'call hooks#plugins#rust()'
        \ })

  call dein#add('mhinz/vim-rfc', { 'on_cmd': ['RFC', 'RFC!'] })

  call dein#add('junegunn/fzf', {
        \ 'build': './install --bin',
        \ 'on_source': 'fzf.vim',
        \ 'hook_source': 'call hooks#plugins#fzf()'
        \ })
  call dein#add('junegunn/fzf.vim', {
        \ 'depends': 'fzf',
        \ 'on_cmd': ['Colors', 'Rg', 'Rgg','Buffers', 'Files']
        \ })

  call dein#end()
  call dein#save_state()
endif
