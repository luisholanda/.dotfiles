set termguicolors
lua require('init')
filetype plugin indent off
packadd vim-polyglot

filetype on

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
colorscheme sonokai

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

" Make comments italic.
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
