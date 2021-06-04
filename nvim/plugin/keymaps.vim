nnoremap <silent> :w<CR>  :up<CR>
nnoremap <silent> :W<CR>  :w<CR>
nnoremap <silent> :WQ<CR> :wq<CR>
nnoremap <silent> :wQ<CR> :wq<CR>
nnoremap <silent> :Wq<CR> :wq<CR>
nnoremap <silent> :Q<CR>  :q<CR>

nnoremap <silent> <leader>bd :Bclose<CR>
nnoremap <silent> <leader>q  :q<CR>

inoremap <up> <nop>
inoremap <down> <nop>
nnoremap <silent> <left> :bp<CR>
nnoremap <silent> <right> :bn<CR>
nnoremap <CR><CR> <c-^>

nnoremap Y y$

" Window commands
nnoremap <silent> <leader>ww <cmd>up<CR>
nnoremap <silent> <leader>ws <cmd>rightbelow split<CR>
nnoremap <silent> <leader>wv <cmd>rightbelow vsplit<CR>
nnoremap <silent> <leader>wh <cmd>wincmd h<CR>
nnoremap <silent> <leader>wj <cmd>wincmd j<CR>
nnoremap <silent> <leader>wk <cmd>wincmd k<CR>
nnoremap <silent> <leader>wl <cmd>wincmd l<CR>
nnoremap <silent> <leader>wq <cmd>wincmd c<CR>
nnoremap <silent> <tab>      <cmd>wincmd w<CR>

" Search
nnoremap <leader>sf <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>sg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>sb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>sh <cmd>lua require('telescope.builtin').help_tags()<cr>

" LSP stuff
nnoremap <silent> gd         <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD         <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gi         <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K          <cmd>lua require'lspsaga.hover'.render_hover_doc()<CR>
nnoremap <silent> [d         <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]d         <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
inoremap <silent> <c-k>      <cmd>lua require'lspsaga.signaturehelp'.signature_help()<CR>
nnoremap <silent> <leader>lh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> <leader>ld <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent> <leader>lf <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>la <cmd>lua require'lspsaga.codeaction'.code_action()<CR>
vnoremap <silent> <leader>la <cmd>lua require'lspsaga.codeaction'.range_code_action()<CR>
nnoremap <silent> <leader>do <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> <leader>rn <cmd>lua require'lspsaga.rename'.rename()<CR>

nnoremap <silent> <C-f>      <cmd>lua require'lspsaga.hover'.smart_scroll_hover(1)<CR>
nnoremap <silent> <C-b>      <cmd>lua require'lspsaga.hover'.smart_scroll_hover(-1)<CR>

" Git
nnoremap <silent> <leader>gs <cmd>lua require'neogit'.open({ kind = 'split' })<CR>
nnoremap <silent> <leader>gc <cmd>lua require'neogit'.open({ "commit" })<CR>
nnoremap <silent> <leader>gl <cmd>lua require'neogit'.open({ "log" })<CR>
nnoremap <silent> <leader>ghpl <cmd>Octo pr list<CR>
nnoremap <silent> <leader>ghpe <cmd>Octo pr edit<space>
nnoremap <silent> <leader>ghpo <cmd>Octo pr open<CR>

" " Terminal mode stuff
nnoremap <silent> <leader>t  <cmd>terminal<CR>
nnoremap <silent> <leader>T  <cmd>rightbelow vsplit<CR><cmd>terminal<CR>
