command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

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

nmap <leader>sf :Files<CR>
nmap <leader>sb :Buffers<CR>
nmap <leader>sg :Rg<CR>
nmap <leader>sc :noh<CR>

let $FZF_DEFAULT_OPTS='--layout=reverse'

let g:fzf_action = {
      \ 'ctrl-t': 'tap split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \}
let g:fzf_layout = { 'window':  'call floating_fzf#FloatingFZF()' }
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
