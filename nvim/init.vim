let loaded_matchparen = 1
let g:async_open = 14
let g:indentLine_char = "▏"
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:diagnostic_virtual_text_prefix = 1

lua require('init')

filetype plugin indent on

" Replace the line number highlight from the Snow Dark colorscheme.
augroup CursorLineHighlight
  " Make the rest of number darker.
  autocmd! ColorScheme snow highlight LineNr ctermfg=236 guifg=#2c2d30
  " Highlight the current line and make the number lighter.
  autocmd! ColorScheme snow highlight CursorLineNr ctermfg=249 ctermbg=237 guifg=#afb7c0 guibg=#363a3e
augroup END

set background=dark
colorscheme meh

augroup NumberToggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

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
  autocmd! FileType fzf tnoremap <buffer> <Esc> <C-c>
augroup END

autocmd ColorScheme * highlight NonText guifg=bg
autocmd ColorScheme * highlight VertSplit guifg=bg

" Auto close pop-up menu when finish completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

augroup CompleteionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']
    autocmd BufEnter *.rust let g:completion_trigger_character = ['.','::']
    autocmd BufEnter * lua require'completion'.on_attach()
augroup end

" Make comments italic.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
augroup ColorschemePatches
    autocmd!
    autocmd ColorScheme * highlight Comment cterm=italic gui=italic
    autocmd ColorScheme meh highlight Keyword cterm=bold gui=bold
augroup end

" Spell checking
set spell
set spelllang=en_US
