let g:EasyMotion_do_mapping = 0
let g:EasyMotion_prompt = "Jump to →"
let g:EasyMotion_keys = "fjdkswbeoavn"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1

let g:gitgutter_map_keys = 0
let g:gitgutter_sign_added =  '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '◢'
let g:gitgutter_sign_removed_first_line = '◥'
let g:gitgutter_sign_modified_removed = '◢'
let g:gitgutter_override_sign_column_highlight = 0

let g:crystalline_enable_sep = 1
let g:crystalline_separators = ['', '']
let g:crystalline_tabline_fn = 'sl#bufferline'
let g:crystalline_theme = 'meh'
let g:crystalline_supported_sep = {
      \ 'InsertMode': ['', 'Fill', 'TabFill', 'Tab', 'TabSel'],
      \ 'ReplaceMode': ['', 'Fill', 'TabFill', 'Tab', 'TabSel'],
      \ 'TabSel': ['Tab', 'TabFill', 'InsertMode', 'ReplaceMode'],
      \ 'TabFill': ['Tab', 'TabSel', 'TabFill', 'NormalMode', 'InsertMode', 'VisualMode', 'ReplaceMode'],
      \}

let g:webdevicons_enable_nerdtree = 0
let g:webdevicons_enable_unite = 0
let g:webdevicons_enable_vimfiler = 0
let g:webdevicons_enable_airline_tabline = 0
let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_ctrlp = 0
let g:webdevicons_enable_startify = 0
let g:webdevicons_enable_flagship_statusline = 0
let g:webdevicons_enable_denite = 0

let g:fzf_action = {
      \ 'ctrl-t': 'tap split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \}
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