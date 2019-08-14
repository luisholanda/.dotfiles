set guicursor+=a:blinkwait800-blinkon600-blinkoff400

if exists('g:fvim_loaded')
  set guifont=PragmataPro:h12
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=+<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  FVimCursorSmoothBlink v:true
  FVimCursorSmoothMove v:false

  FVimFontNormalWeight 300
  FVimFontBoldWeight 800
endif
