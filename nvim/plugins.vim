set runtimepath+=~/.local/share/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/nvim/dein')
  call dein#begin('~/.local/share/nvim/dein')

  call dein#add('Shougo/dein.vim')
  call dein#add('airblade/vim-rooter')
  call dein#add('zhimsel/vim-stay')

  " call dein#add('liuchengxu/space-vim-theme')
  " call dein#add('mhinz/vim-janah')
  " call dein#add('lifepillar/vim-gruvbox8')
  " call dein#add('shinchu/lightline-gruvbox.vim')
  " call dein#add('junegunn/seoul256.vim')
  call dein#add('srcery-colors/srcery-vim')

  call dein#add('ryanoasis/vim-devicons')
  call dein#add('Yggdroot/indentLine')

  call dein#add('neoclide/coc.nvim', {
        \ 'build': 'yarn install --frozen-lockfile',
        \ })
  call dein#add('liuchengxu/vista.vim', { 'on_cmd': ['Vista', 'Vista!', 'Vista!!'] })

  call dein#add('yuttie/comfortable-motion.vim', {
        \ 'on_func': ['comfortable_motion#flick'],
        \ 'hook_source': join(['let g:comfortable_motion_no_default_key_mappings = 1',
        \                   'let g:comfortable_motion_impulse_multiplier = 1'], '\n')
        \ })

  call dein#add('skywind3000/asyncrun.vim', { 'on_cmd': 'AsyncRun' })
  call dein#add('airblade/vim-gitgutter', { 'on_event': 'BufReadPost' })
  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-surround')
  call dein#add('itchyny/lightline.vim')
  call dein#add('easymotion/vim-easymotion', {
        \ 'on_map': '<Plug>',
        \ 'hook_source': join(['let g:EasyMotion_do_mapping = 0',
        \                      'let g:EasyMotion_prompt = "Jump to → "',
        \                      'let g:EasyMotion_keys = "fjdkswbeoavn"',
        \                      'let g:EasyMotion_smartcase = 1',
        \                      'let g:EasyMotion_use_smartsign_us = 1'], '\n')
        \ })
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('matze/vim-move')
  call dein#add('tpope/vim-fugitive', { 'on_event': 'BufReadPost' })
  call dein#add('sodapopcan/vim-twiggy', { 'on_cmd': 'Twiggy' })
  call dein#add('junegunn/gv.vim', { 'on_cmd': 'GV' })
  call dein#add('markonm/traces.vim', { 'on_event': 'BufReadPost' })
  call dein#add('terryma/vim-expand-region', { 'on_map':  '<Plug>' })

  call dein#add('TaDaa/vimade', { 'on_event': 'WinNew' })

  call dein#add('Shougo/deol.nvim')
  call dein#add('wellle/targets.vim')
  call dein#add('gcmt/wildfire.vim', { 'on_map': '<Plug>' })

  call dein#add('tyru/open-browser.vim', { 'on_ft': ['plantuml'] })
  call dein#add('aklt/plantuml-syntax')
  call dein#add('weirongxu/plantuml-previewer.vim', { 'on_ft': ['plantuml'] })

  call dein#add('wellle/visual-split.vim', {
        \ 'name': 'Visual-Split',
        \ 'on_map': '<Plug>'
        \ })
  call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })

  call dein#add('mhinz/vim-rfc', { 'on_cmd': ['RFC', 'RFC!'] })

  call dein#add('junegunn/fzf', { 'build': './install --bin' })
  call dein#add('junegunn/fzf.vim', {
        \ 'depends': 'fzf',
        \ 'on_cmd': ['Colors', 'Rg', 'Buffers', 'Files'],
        \ 'on_func': 'Fzf_dev'
        \ })

  call dein#end()
  call dein#save_state()
endif

