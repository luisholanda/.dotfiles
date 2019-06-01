set runtimepath+=~/.local/share/nvim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.local/share/nvim/dein')
  call dein#begin('~/.local/share/nvim/dein')

  call dein#add('Shougo/dein.vim')

  " call dein#add('liuchengxu/space-vim-theme')
  call dein#add('mhinz/vim-janah')
  " call dein#add('junegunn/seoul256.vim')

  call dein#add('mhinz/vim-startify')

  call dein#add('Shougo/neco-vim')
  call dein#add('neoclide/coc-neco')
  call dein#add('neoclide/coc.nvim', {
        \ 'build': 'yarn install --frozen-lockfile',
        \ })

  call dein#add('skywind3000/asyncrun.vim', { 'on_cmd': 'AsyncRun' })
  call dein#add('airblade/vim-gitgutter', { 'on_event': 'BufReadPost' })
  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-surround')
  call dein#add('junegunn/vim-easy-align', { 'on_cmd': 'EasyAlign' })
  call dein#add('itchyny/lightline.vim')
  call dein#add('easymotion/vim-easymotion', { 'on_cmd': 'EasyMotion' })
  call dein#add('scrooloose/nerdcommenter', { 'on_map': '<plug>NERDCom' })
  call dein#add('terryma/vim-multiple-cursors')
  call dein#add('matze/vim-move')
  call dein#add('justincampbell/vim-eighties', { 'on_event': 'WinNew' })
  call dein#add('mattn/emmet-vim', { 'on_ft': ['vue', 'html'] })
  call dein#add('rhysd/devdocs.vim', {
        \ 'on_cmd': ['DevDocs', 'DevDocsAll'],
        \ 'on_map': '<Plug>(devdocs'
        \ })
  call dein#add('myusuf3/numbers.vim')
  call dein#add('scrooloose/nerdtree', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('Xuyuanp/nerdtree-git-plugin', { 'on_cmd': 'NERDTreeToggle' })
  call dein#add('RRethy/vim-illuminate')
  call dein#add('tpope/vim-fugitive', { 'on_event': 'BufReadPost' })
  call dein#add('sodapopcan/vim-twiggy', { 'on_cmd': 'Twiggy' })
  call dein#add('junegunn/gv.vim', { 'on_cmd': 'GV' })
  call dein#add('tpope/vim-sleuth', { 'on_event': 'BufReadPost' })
  call dein#add('markonm/traces.vim', { 'on_event': 'BufReadPost' })

  call dein#add('TaDaa/vimade', { 'on_event': 'WinNew' })

  call dein#add('Shougo/deol.nvim')
  call dein#add('wellle/targets.vim')
  call dein#add('gcmt/wildfire.vim', { 'on_map': '<Plug>' })

  call dein#add('tyru/open-browser.vim', { 'on_ft': ['plantuml'] })
  call dein#add('aklt/plantuml-syntax')
  call dein#add('weirongxu/plantuml-previewer.vim', { 'on_ft': ['plantuml'] })
  call dein#add('scrooloose/vim-slumlord')

  call dein#add('AndrewRadev/splitjoin.vim', {
        \ 'on_cmd': ['SplitjoinJoin', 'SplitjoinSplit']
        \ })
  call dein#add('wellle/visual-split.vim', {
        \ 'name': 'Visual-Split',
        \ 'on_map': '<Plug>'
        \ })
  call dein#add('rust-lang/rust.vim', { 'on_ft': 'rust' })

  call dein#add('mhinz/vim-rfc', { 'on_cmd': ['RFC', 'RFC!'] })

  call dein#add('junegunn/fzf', { 'build': './install --bin' })
  call dein#add('junegunn/fzf.vim')

  call dein#end()
  call dein#save_state()
endif

