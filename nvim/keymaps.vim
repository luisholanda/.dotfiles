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
noremap <silent> <leader>ww :wincmd w<CR>
noremap <silent> <leader>wq :wincmd c<CR>

if dein#tap('asyncrun.vim')
  noremap ! :AsyncRun<space>
endif

if dein#tap('vim-easymotion')
  nmap <leader><leader>w <Plug>(easymotion-bd-w)
  nmap <leader><leader>f <Plug>(easymotion-bd-f2)
  nmap <leader><leader>t <Plug>(easymotion-bd-t2)
  nmap <leader><leader>e <Plug>(easymotion-bd-e)
  nmap <leader><leader>s <Plug>(easymotion-sn)

  xmap <leader><leader>w <Plug>(easymotion-bd-w)
  xmap <leader><leader>f <Plug>(easymotion-bd-f2)
  xmap <leader><leader>t <Plug>(easymotion-bd-t2)
  xmap <leader><leader>e <Plug>(easymotion-bd-e)
  xmap <leader><leader>s <Plug>(easymotion-sn)

  omap <leader><leader>w <Plug>(easymotion-bd-w)
  omap <leader><leader>f <Plug>(easymotion-bd-f2)
  omap <leader><leader>t <Plug>(easymotion-bd-t2)
  omap <leader><leader>e <Plug>(easymotion-bd-e)
  omap <leader><leader>s <Plug>(easymotion-sn)
endif

if dein#tap('comfortable-motion.vim')
    nnoremap <silent> <C-d> :call motion#flick(2)<CR>
    nnoremap <silent> <C-u> :call motion#flick(-2)<CR>
    nnoremap <silent> <C-f> :call motion#flick(4)<CR>
    nnoremap <silent> <C-b> :call motion#flick(-4)<CR>

    nnoremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
    nnoremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
endif

" Vim Fugitive
if dein#tap('vim-fugitive')
  noremap <leader>gs :Gstatus<CR>
  noremap <leader>gb :Gblame<CR>
  noremap <leader>gd :Gdiff<CR>
  noremap <leader>gp :Gpull --rebase<CR>
  noremap <leader>gP :Gpush<CR>
  noremap <leader>gf :Gfetch<CR>
  noremap <leader>ga :Gwrite<CR>
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

inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>

nnoremap Y y$
