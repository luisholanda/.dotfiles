if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --follow'
  set grepprg=rg\ --vimgrep

  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter: --nth 4..'}, 'up:60%')
    \           : fzf#vim#with_preview({'options': '--delimiter: --nth 4..'}, 'right:50%:hidden', '?'),
    \   <bang>0)
endif

command! -bang -nargs=* Files
      \ call fzf#files_with_dev_icons($FZF_DEFAULT_COMMAND)

nmap <leader>sf :Files<CR>
nmap <leader>sb :Buffers<CR>
nmap <leader>sg :Rg<CR>
nmap <leader>sc :noh<CR>
