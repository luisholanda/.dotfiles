vim.g.async_open = 14

vim.g.indent_blankline_char = "▏"
vim.g.indent_blankline_use_treesitter = 1

vim.g.indicator_errors = ''
vim.g.indicator_warnings = ''
vim.g.indicator_info = 'כֿ'
vim.g.indicator_hint = '!'
vim.g.indicator_ok = ''
vim.g.spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

vim.g.db_ui_env_variable_url = 'DATABASE_URL'
vim.g.db_ui_env_variable_name = 'DB_NAME'

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
