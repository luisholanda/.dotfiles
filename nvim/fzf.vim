let g:fzf_layout = { 'window': 'call window#create_centered_window()' }

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
        \ 'window': 'call window#create_centered_window()'})

endfunction

nmap <silent> <leader>sf :call <SID>Fzf_dev()<CR>
nmap <silent> <leader>sb :Buffers<CR>
