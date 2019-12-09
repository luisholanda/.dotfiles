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

nmap <silent> <leader>sf :call fzf#files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR>
nmap <silent> <leader>sb :Buffers<CR>
nmap <silent> <leader>sg :Rg<CR>
nmap <silent> <leader>sc :noh<CR>
