let s:lua_create_centered_window = luaeval("require('windows').create_centered_window")

function! window#create_centered_window()
  call s:lua_create_centered_window()
endfunction
