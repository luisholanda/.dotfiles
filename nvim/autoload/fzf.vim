function! fzf#files_with_dev_icons(command)
  let l:fzf_files_options  = '--preview "bat --color always --style numbers {2..} |head -'.&lines.'"'

  call fzf#run({
        \ 'source':  a:command.' | devicon-lookup',
        \ 'sink': function('fzf#prepend_file'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down': '40%' })
endfunction

function! fzf#prepend_file(item)
  let l:file_path = a:item[4:-1]

  execute 'silent e' l:file_path
endfunction

