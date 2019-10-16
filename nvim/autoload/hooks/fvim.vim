function! hooks#fvim#startup()
  set guicursor+=a:blinkwait800-blinkon600-blinkoff400

  set guifont=Iosevka:h12
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  FVimCursorSmoothBlink v:true
  FVimCursorSmoothMove v:false

  FVimFontNormalWeight 300
  FVimFontBoldWeight 800

  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontSubpixel v:true
  FVimFontLcdRender v:true
  FVimFontHintLevel 'full'

  FVimUIPopupMenu v:true
  FVimFontAutoSnap v:true
endfunction
