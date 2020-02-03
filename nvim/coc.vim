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

function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  else
    return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
  endif
endfunction

augroup coc_nvimgroup
  autocmd!
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

nnoremap <silent> <C-c> <Plug>(coc-cursor-position)
nnoremap <expr> <silent> <C-d> <SID>select_current_word()
nnoremap <leader>x <Plug>(coc-cursors-operator)

xnoremap <silent> <leader>a <Plug>(coc-codeaction-selected)
nnoremap <silent> <leader>a <Plug>(coc-codeaction-selected)

nnoremap <silent> <leader>c <Plug>(coc-codeaction)
nnoremap <silent> <leader>qf <plug>(coc-fix-current)
nnoremap <silent> <leader>lrn <Plug>(coc-rename)
nnoremap <silent> <leader>lrf <Plug>(coc-refactor)
nnoremap <silent> <leader>la :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>le :<C-u>CocList extensions<cr>
nnoremap <silent> <leader>lc :<C-u>CocList commands<cr>
nnoremap <silent> <leader>lf :call CocAction('format')<cr>
nnoremap <silent> <leader>ls :execute 'CocSearch -w '.expand('<cword>')<CR>
nnoremap <silent> <leader>lt :Vista coc<CR>
nnoremap <silent> [c <Plug>(coc-definition-prev)
nnoremap <silent> ]c <Plug>(coc-definition-next)

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call CocAction('doHover')<CR>

let g:vista_default_executive = 'coc'
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#ctags = 'kind'
let g:vista_sidebar_width = 50
