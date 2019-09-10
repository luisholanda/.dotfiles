function! floating_fzf#FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number', 'no')
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(&lines/2)
  let width = float2nr(&columns - (&columns * 2 / 10))

  let col = float2nr((&columns - width) / 2)

  let opts = {
      \ 'relative': 'editor',
      \ 'row': 1,
      \ 'col': col,
      \ 'width': width,
      \ 'height': height,
      \ }

  let win = nvim_open_win(buf, v:true, opts)

  cal setwinvar(win, '&number', 0)
  cal setwinvar(win, '&relativenumber', 0)
endfunction

