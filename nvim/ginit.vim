nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
nnoremap <silent> <C-ScrollWheelDown> :set guifont=+<CR>

if exists('g:fvim_loaded')
  call hooks#fvim#startup()
elseif has('gui_vimr')
  call hooks#vimr#startup()
endif
