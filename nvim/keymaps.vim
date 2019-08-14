noremap :w<CR> :up<CR>
noremap :W<CR> :w<CR>
noremap :WQ<CR> :wq<CR>
noremap :wQ<CR> :wq<CR>
noremap :Wq<CR> :wq<CR>
noremap :Q<CR> :q<CR>

noremap <leader>w :up<CR>
noremap <leader>q :q<CR>

noremap ! :AsyncRun<space>
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

if dein#tap('vim-easymotion')
  nmap <leader><leader>w <Plug>(easymotion-bd-w)
  nmap <leader><leader>f <Plug>(easymotion-bd-f)
  nmap <leader><leader>e <Plug>(easymotion-bd-e)
  nmap <leader><leader>s <Plug>(easymotion-sn)
endif

if dein#tap('comfortable-motion.vim')
    nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
    nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
    nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
    nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>

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
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <CR><CR> <c-^>

inoremap ( ()<left>
inoremap { {}<left>
inoremap [ []<left>

nnoremap Y y$
