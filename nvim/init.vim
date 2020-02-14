source ~/.dotfiles/nvim/essentials.vim
source ~/.dotfiles/nvim/plugins.vim
source ~/.dotfiles/nvim/fzf.vim
source ~/.dotfiles/nvim/keymaps.vim

filetype plugin indent on

" Replace the line number highlight from the Snow Dark colorscheme.
augroup CursorLineHighlight
  " Make the rest of number darker.
  autocmd! ColorScheme * highlight LineNr ctermfg=236 guifg=#2c2d30
  " Highlight the current line and make the number lighter.
  autocmd! ColorScheme * highlight CursorLineNr ctermfg=249 ctermbg=237 guifg=#afb7c0 guibg=#363a3e
augroup END

" Make comments italic.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
augroup ItalicComments
  autocmd! ColorScheme * highlight Comment cterm=italic gui=italic
augroup END

set background=dark
colorscheme snow

augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

if dein#tap('Shougo/echodoc.vim')
  let g:echodoc_enable_at_startup = 1
  let g:echodoc#type = 'virtual'
endif

command! -bang -complete=buffer -nargs=? Bclose call bclose#close_buffer(<q-bang>, <q-args>)
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
autocmd BufNew,BufNewFile,BufRead *.lalrpop :setlocal filetype=rust

autocmd BufWritePre * %s/\s\+$//e
autocmd FileType help wincmd L

augroup TermHandling
  autocmd!
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
        \ | startinsert
        \ | tnoremap <buffer> <Esc> <C-c>
        \ | IndentLinesDisable
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END

autocmd ColorScheme * highlight NonText guifg=bg
autocmd ColorScheme * highlight VertSplit guibg=#2c2d30 ctermbg=236

let g:lsp_diagnostics_float_cursor = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_highlight_references_enabled = 1
let g:lsp_semantic_enabled = 1
let g:lsp_signs_priority = 11
let g:deoplete_enable_at_startup = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼' }

function! s:on_lsp_buffer_enabled() abort
  call deoplete#enable()

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#manual_complete()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> deoplete#manual_complete()

  nnoremap <silent><buffer> gd :LspPeekDefinition<CR>
  nnoremap <silent><buffer> gD :LspDefinition<CR>
  nnoremap <silent><buffer> K :LspHover<CR>
  nnoremap <silent><buffer> <leader>rn :LspRename<CR>
  nnoremap <silent><buffer> <leader>lf :LspDocumentFormat<CR>
  vnoremap <silent><buffer> <leader>lf :LspDocumentFormat<CR>
  nnoremap <silent><buffer> <leader>lf :LspDocumentRangeFormat<CR>
  xnoremap <silent><buffer> <leader>lf :LspDocumentRangeFormat<CR>

  set foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
