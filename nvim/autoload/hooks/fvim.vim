function! hooks#fvim#startup()
  set guicursor+=a:blinkwait800-blinkon600-blinkoff400

  set guifont=PragmataPro:h13
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  FVimCursorSmoothBlink v:true
  FVimCursorSmoothMove v:false

  FVimFontNormalWeight 300
  FVimFontBoldWeight 800

  FVimFontAntialias v:true
  FVimFontAutohint v:true
  FVimFontSubpixel v:true
  FVimFontLcdRender v:true
  FVimFontLigature v:true
  FVimFontLineHeight '+0.2'
  FVimFontHintLevel 'full'

  FVimUIMultiGrid v:false
  FVimUIPopupMenu v:false
  FVimCustomTitleBar v:false
  FVimFontAutoSnap v:true
endfunction
