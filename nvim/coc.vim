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

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  else
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup coc_nvimgroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


nmap <silent> <C-c> <Plug>(coc-cursor-position)
nmap <expr> <silent> <C-d> <SID>select_current_word()
nmap <leader>x <Plug>(coc-cursors-operator)

xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>c <Plug>(coc-codeaction)
nnoremap <silent> <leader>qf <plug>(coc-fix-current)
nnoremap <silent> <leader>lr <Plug>(coc-rename)
nnoremap <silent> <leader>lf <Plug>(coc-refactor)
nnoremap <silent> <leader>la :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>le :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>lc :<C-u>CocList commands<cr>
nnoremap <silent> <leader>lo :<C-u>CocList outline<cr>
nnoremap <silent> <leader>lf :call CocAction('format')<cr>
nnoremap <silent> <leader>lj :<C-u>CocNext<cr>
nnoremap <silent> <leader>lk :<C-u>CocPrev<cr>
nnoremap <silent> <leader>lp :<C-u>CocListResume<cr>
nnoremap <silent> <leader>ls :execute 'CocSearch -w '.expand('<cword>')<CR>
nnoremap <silent> <leader>lt :Vista coc<CR>
nnoremap <silent> [c <Plug>(coc-definition-prev)
nnoremap <silent> ]c <Plug>(coc-definition-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call <SID>show_documentation()<CR>

let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#ctags = 'kind'
let g:vista_sidebar_width = 50
