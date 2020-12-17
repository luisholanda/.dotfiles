nnoremap <silent> :w<CR>  :up<CR>
nnoremap <silent> :W<CR>  :w<CR>
nnoremap <silent> :WQ<CR> :wq<CR>
nnoremap <silent> :wQ<CR> :wq<CR>
nnoremap <silent> :Wq<CR> :wq<CR>
nnoremap <silent> :Q<CR>  :q<CR>

nnoremap <silent> <leader>bd :Bclose<CR>
nnoremap <silent> <leader>q  :q<CR>

nnoremap <silent> <leader>ww <cmd>up<CR>
nnoremap <silent> <leader>ws <cmd>rightbelow split<CR>
nnoremap <silent> <leader>wv <cmd>rightbelow vsplit<CR>
nnoremap <silent> <leader>wh <cmd>wincmd h<CR>
nnoremap <silent> <leader>wj <cmd>wincmd j<CR>
nnoremap <silent> <leader>wk <cmd>wincmd k<CR>
nnoremap <silent> <leader>wl <cmd>wincmd l<CR>
nnoremap <silent> <leader>wq <cmd>wincmd c<CR>
nnoremap <silent> <tab>      <cmd>wincmd w<CR>

nnoremap <silent> gd         <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD         <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K          <cmd>lua vim.lsp.buf.hover()<CR>
inoremap <silent> <c-k>      <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>lr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>ld <cmd>lua vim.lsp.buf.peek_definition()<CR>
nnoremap <silent> <leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>do <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>

inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <silent> <left> :bp<CR>
nnoremap <silent> <right> :bn<CR>
nnoremap <CR><CR> <c-^>

nnoremap Y y$

" Terminal mode stuff
nnoremap <silent> <leader>t  <cmd>terminal<CR>
nnoremap <silent> <leader>T  <cmd>rightbelow vsplit<CR><cmd>terminal<CR>
tnoremap <silent> <Esc>      <C-\><C-n>
tnoremap <silent> <leader>bd <C-\><C-n><cmd>Bclose!<CR>
tnoremap <silent> <leader>wh <C-\><C-n><cmd>wincmd h<CR>
tnoremap <silent> <leader>wj <C-\><C-n><cmd>wincmd j<CR>
tnoremap <silent> <leader>wk <C-\><C-n><cmd>wincmd k<CR>
tnoremap <silent> <leader>wl <C-\><C-n><cmd>wincmd l<CR>
tnoremap <silent> <leader>wq <C-\><C-n><cmd>wincmd c<CR>
