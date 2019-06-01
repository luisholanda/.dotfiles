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

noremap <leader>d <Plug>(devdocs-under-cursor)

noremap <leader>sj :SplitjoinJoin<CR>
noremap <leader>ss :SplitjoinSplit<CR>

noremap <leader>vsr <Plug>(Visual-Split-VSResize)
noremap <leader>vss <Plug>(Visual-Split-VSSplit)
noremap <leader>vsa <Plug>(Visual-Split-VSSplitAbove)
noremap <leader>vsb <Plug>(Visual-Split-VSSplitBelow)

" Vim Fugitive
noremap <leader>gs :Gstatus<CR>
noremap <leader>gb :Gblame<CR>
noremap <leader>gd :Gdiff<CR>
noremap <leader>gt :Twiggy<CR>
noremap <leader>gl :GV<CR>
noremap <leader>gc :Twiggy<space>
noremap <leader>gp :Gpull --rebase<CR>
noremap <leader>gP :Gpush<CR>
noremap <leader>gf :Gfetch<CR>
noremap <leader>ga :Gwrite<CR>

noremap <leader>ft :NERDTreeToggle<CR>

inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
nnoremap <leader><leader> <c-^>
