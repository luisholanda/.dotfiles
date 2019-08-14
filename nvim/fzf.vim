command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number', 'no')
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(&lines/2)
  let width = float2nr(&columns - (&columns * 2 / 10))

  let row = float2nr(&lines / 3)
  let col = float2nr((&columns - width) / 2)

  let opts = {
      \ 'relative': 'editor',
      \ 'row': row,
      \ 'col': col,
      \ 'width': width,
      \ 'height': height,
      \ }

  let win = nvim_open_win(buf, v:true, opts)

  cal setwinvar(win, '&number', 0)
  cal setwinvar(win, '&relativenumber', 0)
endfunction

function! Fzf_dev()
  let l:fzf_file_options =  ' --preview "rougify {2..-1} | head -'.&lines.'"'

  function! s:files()
    let l:files = split(system('rg --files --hidden --follow'), '\n')

    return s:prepend_icon(l:files)
  endfunction

  function! s:prepend_icon(candidates)
    let l:result = []

    for l:candidate in a:candidates
      let l:filename = fnamemodify(l:candidate, ':p:t')
      let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
      call add(l:result, printf('%s %s', l:icon, l:candidate))
    endfor

    return l:result
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, '  ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run(fzf#wrap({
      \ 'source': <sid>files(),
      \ 'sink': function('s:edit_file'),
      \ 'options': '-m ' . l:fzf_file_options,
      \ 'down': '10%',
      \ 'window': 'call FloatingFZF()'
      \ }))
endfunction

nmap <leader>sf :Files<CR>
nmap <leader>sb :Buffers<CR>
nmap <leader>sg :Rg<CR>
nmap <leader>sc :noh<CR>

let g:fzf_action = {
      \ 'ctrl-t': 'tap split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \}
let g:fzf_layout = { 'window':  'call FloatingFZF()' }
let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(read)%d%C(reset)"
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)'
