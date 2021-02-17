lua require('init')
filetype plugin indent off
" packadd vim-polyglot

filetype on

" Replace the line number highlight from the Snow Dark colorscheme.
augroup CursorLineHighlight
  " Make the rest of number darker.
  autocmd! ColorScheme snow highlight LineNr ctermfg=236 guifg=#2c2d30
  " Highlight the current line and make the number lighter.
  autocmd! ColorScheme snow highlight CursorLineNr ctermfg=249 ctermbg=237 guifg=#afb7c0 guibg=#363a3e
augroup END

set background=dark

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

" Configure completion triggers for LSP client.
augroup CompletionTriggerCharacter
    autocmd!
    autocmd BufEnter * let g:completion_trigger_character = ['.']
    autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->']
    autocmd BufEnter *.rust let g:completion_trigger_character = ['.','::']
augroup END

" Extra commands specifics for LSP servers.
augroup LspCmds
    autocmd!
    " Enable rust-analyzer type hints.
    autocmd InsertLeave,BufEnter,BufWinEnter,TabEnter *.rs lua require('lsp_extensions').inlay_hints{ prefix = ' » ', highlight = 'NonText' }
    " Update Code Actions lightbulb.
    autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()
    "autocmd CursorHold,CursorHoldI * lua require('lspsaga.signaturehelp').signature_help()
    "autocmd User LspMessageUpdate call sl#update_lsp_messages()
augroup END

" Make comments italic.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
augroup ColorschemePatches
    autocmd!
    autocmd ColorScheme * highlight Comment cterm=italic gui=italic
    autocmd ColorScheme meh highlight Keyword cterm=bold gui=bold
    autocmd ColorScheme meh
      \| highlight link LspDiagnosticsError Error
      \| highlight link LspDiagnosticsErrorFLoating ErrorMsg
      \| highlight link LspDiagnosticsErrorSign ErrorMsg
      \| highlight link LspDiagnosticsWarning Warning
      \| highlight link LspDiagnosticsWarningFLoating WarningMsg
      \| highlight link LspDiagnosticsWarningSign WarningMsg
      \| highlight link LspDiagnosticsHint Hint
      \| highlight link LspDiagnosticsHintFLoating HintMsg
      \| highlight link LspDiagnosticsHintSign HintMsg
      \| highlight link LspDiagnosticsInformation Info
      \| highlight link LspDiagnosticsInformationFLoating InfoMsg
      \| highlight link LspDiagnosticsInformationSign InfoMsg
      \| highlight LspDiagnosticsUnderline        guifg=NONE guibg=NONE guisp=LightGray gui=underline
      \| highlight LspDiagnosticsUnderlineError   guifg=NONE guibg=NONE guisp=Red gui=underline
      \| highlight LspDiagnosticsUnderlineHint    guifg=NONE guibg=NONE guisp=LightGreen gui=underline
      \| highlight LspDiagnosticsUnderlineInfo    guifg=NONE guibg=NONE guisp=LightBlue gui=underline
      \| highlight LspDiagnosticsUnderlineWarning guifg=NONE guibg=NONE guisp=Yellow gui=underline
augroup END

autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
