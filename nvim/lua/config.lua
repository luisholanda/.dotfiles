local g = vim.g;

g.async_open = 14

g.indent_blankline_char = "▏"
g.indent_blankline_use_treesitter = 1

g.indicator_errors = ''
g.indicator_warnings = ''
g.indicator_info = 'כֿ'
g.indicator_hint = '!'
g.indicator_ok = ''
g.spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'}

g.db_ui_env_variable_url = 'DATABASE_URL'
g.db_ui_env_variable_name = 'DB_NAME'

g.fzf_colors = {
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

g.fzf_commits_log_options = '--graph --color=always ' ..
  '--format="%C(yellow)%h%C(read)%d%C(reset)" ' ..
  '- %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)'

g.tex_flavor = "latex"
