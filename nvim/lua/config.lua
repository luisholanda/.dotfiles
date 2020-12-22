vim.g.async_open = 14
vim.g.indentLine_char = "▏"
vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
vim.g.completion_matching_smart_case = 1

vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_prompt = "Jump to →"
vim.g.EasyMotion_keys = "fjdkswbeoavn"
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_use_smartsign_us = 1

vim.g.gitgutter_map_keys = 0
vim.g.gitgutter_sign_added =  '┃'
vim.g.gitgutter_sign_modified = '┃'
vim.g.gitgutter_sign_removed = '◢'
vim.g.gitgutter_sign_removed_first_line = '◥'
vim.g.gitgutter_sign_modified_removed = '◢'
vim.g.gitgutter_override_sign_column_highlight = 0

vim.g.crystalline_enable_sep = 1
vim.g.crystalline_separators = {'', ''}
vim.g.crystalline_tabline_fn = 'sl#tabline'
vim.g.crystalline_statusline_fn = 'sl#statusline'
vim.g.crystalline_theme = 'zephyr'
vim.g.crystalline_supported_sep = {
  InsertMode  = {'', 'Fill', 'TabFill', 'Tab', 'TabSel'},
  ReplaceMode = {'', 'Fill', 'TabFill', 'Tab', 'TabSel'},
  TabSel      = {'Tab', 'TabFill', 'InsertMode', 'ReplaceMode'},
  TabFill     = {'Tab', 'TabSel', 'TabFill', 'NormalMode', 'InsertMode', 'VisualMode', 'ReplaceMode'},
}

vim.g.indicator_errors = ''
vim.g.indicator_warnings = ''
vim.g.indicator_info = 'כֿ'
vim.g.indicator_hint = '!'
vim.g.indicator_ok = ''
vim.g.spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

vim.g.fzf_action = {
  ['ctrl-t'] = 'tap split',
  ['ctrl-x'] = 'split',
  ['ctrl-v'] = 'vsplit'
}

vim.g.fzf_colors = {
  fg      = {'fg', 'Normal'},
  bg      = {'bg', 'Normal'},
  hl      = {'fg', 'Comment'},
  ['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
  ['bg+'] = {'bg', 'CursorLine', 'CursorColumn'},
  ['hl+'] = {'fg', 'Statement'},
  info    = {'fg', 'PreProc'},
  border  = {'fg', 'Ignore'},
  prompt  = {'fg', 'Conditional'},
  pointer = {'fg', 'Exception'},
  marker  = {'fg', 'Keyword'},
  spinner = {'fg', 'Label'},
  header  = {'fg', 'Comment'}
}

vim.g.fzf_commits_log_options = '--graph --color=always ' ..
  '--format="%C(yellow)%h%C(read)%d%C(reset)" ' ..
  '- %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)'
