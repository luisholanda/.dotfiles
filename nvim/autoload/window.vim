let s:borders_cache = {}

function! s:get_borders(width, height)
  let l:key = a:width . a:height
  let l:borders = get(s:borders_cache, l:key, [])
  if len(l:borders) == 0
    let l:top = "╭" . repeat("─", a:width - 2) . "╮"
    let l:mid = "│" . repeat(" ", a:width - 2) . "│"
    let l:bot = "╰" . repeat("─", a:width - 2) . "╯"

    let s:borders_cache[l:key] = [l:top] + repeat([l:mid], a:height - 2) + [l:bot]

    let l:borders = s:borders_cache[l:key]
  endif

  return l:borders
endfunction


function! window#create_centered_window()
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {
        \'relative': 'editor',
        \'row': top,
        \'col': left,
        \'width': width,
        \'height': height,
        \'style': 'minimal'
        \}

  let lines = s:get_borders(width, height)
  let s:buf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
  call nvim_open_win(s:buf, v:true, opts)
  set winhl=Normal:Floating
  let opts.row += 1
  let opts.height -= 2
  let opts.col += 2
  let opts.width -= 4
  call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
  au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
