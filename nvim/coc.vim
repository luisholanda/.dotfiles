" coc.nvim things

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col-1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <silent><expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup coc_nvimgroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nnoremap <silent> <leader>la :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>le :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>lc :<C-u>CocList commands<cr>
nnoremap <silent> <leader>lo :<C-u>CocList outline<cr>
nnoremap <silent> <leader>ls :<C-u>CocList -I symbols<cr>
nnoremap <silent> <leader>lf :call CocAction('format')<cr>
nnoremap <silent> <leader>lj :<C-u>CocNext<cr>
nnoremap <silent> <leader>lk :<C-u>CocPrev<cr>
nnoremap <silent> <leader>lp :<C-u>CocListResume<cr>

xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)

nmap <silent> <leader>c <Plug>(coc-codeaction)
nmap <silent> <leader>qf <plug>(coc-fix-current)
nmap <silent> <leader>lr <Plug>(coc-rename)
nmap <silent> [c <Plug>(coc-definition-prev)
nmap <silent> [c <Plug>(coc-definition-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>


let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
