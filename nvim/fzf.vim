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


function! fzf#create_centered_window()
  let width = min([&columns - 4, max([80, &columns - 20])])
  let height = min([&lines - 4, max([20, &lines - 10])])
  let top = ((&lines - height) / 2) - 1
  let left = (&columns - width) / 2
  let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

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

let g:fzf_layout = { 'window': 'call fzf#create_centered_window()' }

let $FZF_DEFAULT_OPTS = "--reverse "


let s:ripgrep_command = 'rg --follow --no-ignore --hidden --column --line-number --no-heading --smart-case --iglob="!.DS_Store" --iglob="!.git"'
let $FZF_DEFAULT_COMMAND = s:ripgrep_command . ' --files'
set grepprg=rg\ --vimgrep

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   s:ripgrep_command.' --color=always '.shellescape(<q-args>), 1,
  \   <bang>0)

nmap <silent> <leader>sg :Rg<CR>
nmap <silent> <leader>sG :Rgg<CR>

" Files + devicons + floating fzf
function! s:Fzf_dev()
  let l:fzf_files_options = '--preview "bat --line-range :'.&lines.' --theme="OneHalfDark" --style=numbers,changes --color always {2..-1}"'

  function! s:files()
    return split(system($FZF_DEFAULT_COMMAND . ' |  devicon-lookup'), '\n')
  endfunction

  function! s:edit_file(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
        \ 'source': <sid>files(),
        \ 'sink':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call fzf#create_centered_window()'})

endfunction

nmap <silent> <leader>sf :call <SID>Fzf_dev()<CR>
nmap <silent> <leader>sb :Buffers<CR>
