function! term#open_term(cmd)
  call window#create_centered_window()
  call termopen(a:cmd, { 'on_exit': {j,c,e -> execute('close | close') } })
endfunction
