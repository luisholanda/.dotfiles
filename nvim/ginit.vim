let g:neovide_cursor_animation_length=0.001
nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
nnoremap <silent> <C-ScrollWheelDown> :set guifont=+<CR>
set guifont=CaskaydiaCove\ Nerd\ Font:h12

if exists('g:fvim_loaded')
  call hooks#fvim#startup()
elseif has('gui_vimr')
  call hooks#vimr#startup()
endif
