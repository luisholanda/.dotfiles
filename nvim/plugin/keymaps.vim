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

noremap ! :AsyncRun<space>

inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <silent> <left> :bp<CR>
nnoremap <silent> <right> :bn<CR>
nnoremap <CR><CR> <c-^>

nnoremap Y y$

" Terminal mode stuff
nnoremap <leader>t :terminal<CR>
tnoremap <silent> <Esc> <C-\><C-n>
