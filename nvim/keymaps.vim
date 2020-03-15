noremap <silent> :w<CR> :up<CR>
noremap <silent> :W<CR> :w<CR>
noremap <silent> :WQ<CR> :wq<CR>
noremap <silent> :wQ<CR> :wq<CR>
noremap <silent> :Wq<CR> :wq<CR>
noremap <silent> :Q<CR> :q<CR>

noremap <silent> <leader>bd :Bclose<CR>
noremap <silent> <leader>q :q<CR>

noremap <silent> <leader>ww :up<CR>
noremap <silent> <leader>ws :rightbelow split<CR>
noremap <silent> <leader>wv :rightbelow vsplit<CR>
noremap <silent> <leader>wh :wincmd h<CR>
noremap <silent> <leader>wj :wincmd j<CR>
noremap <silent> <leader>wk :wincmd k<CR>
noremap <silent> <leader>wl :wincmd l<CR>
noremap <silent> <leader>wq :wincmd c<CR>
noremap <silent> <tab> :wincmd w<CR>

nnoremap <silent> gd <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> pd    <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> ]d :NextDiagnostic<CR>
nnoremap <silent> [d :PrevDiagnostic<CR>
nnoremap <silent> <leader>do :OpenDiagnostic<CR>
nnoremap <silent> <leader>dl <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>

if dein#tap('asyncrun.vim')
  noremap ! :AsyncRun<space>
endif

if dein#tap('vim-easymotion')
  nmap <silent> <leader><leader>w <Plug>(easymotion-bd-w)
  nmap <silent> <leader><leader>f <Plug>(easymotion-bd-f2)
  nmap <silent> <leader><leader>t <Plug>(easymotion-bd-t2)
  nmap <silent> <leader><leader>e <Plug>(easymotion-bd-e)
  nmap <silent> <leader><leader>s <Plug>(easymotion-sn)

  xmap <silent> <leader><leader>w <Plug>(easymotion-bd-w)
  xmap <silent> <leader><leader>f <Plug>(easymotion-bd-f2)
  xmap <silent> <leader><leader>t <Plug>(easymotion-bd-t2)
  xmap <silent> <leader><leader>e <Plug>(easymotion-bd-e)
  xmap <silent> <leader><leader>s <Plug>(easymotion-sn)

  omap <silent> <leader><leader>w <Plug>(easymotion-bd-w)
  omap <silent> <leader><leader>f <Plug>(easymotion-bd-f2)
  omap <silent> <leader><leader>t <Plug>(easymotion-bd-t2)
  omap <silent> <leader><leader>e <Plug>(easymotion-bd-e)
  omap <silent> <leader><leader>s <Plug>(easymotion-sn)
endif

" Vim Fugitive
if dein#tap('vim-fugitive')
  noremap <silent> <leader>gs :Gstatus<CR>
  noremap <silent> <leader>gb :Gblame<CR>
  noremap <silent> <leader>gd :Gdiff<CR>
  noremap <silent> <leader>gp :Gpull --rebase<CR>
  noremap <silent> <leader>gP :Gpush<CR>
  noremap <silent> <leader>gf :Gfetch<CR>
  noremap <silent> <leader>ga :Gwrite<CR>
endif

if dein#tap('vim-twiggy')
  noremap <leader>gt :Twiggy<CR>
  noremap <leader>gc :Twiggy<space>
endif

if dein#tap('gv.vim')
  noremap <leader>gl :GV<CR>
endif

inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <silent> <left> :bp<CR>
nnoremap <silent> <right> :bn<CR>
nnoremap <CR><CR> <c-^>

nnoremap Y y$

" Terminal mode stuff
nnoremap <leader>t :terminal<CR>
tnoremap <silent> <Esc> <C-\><C-n>
