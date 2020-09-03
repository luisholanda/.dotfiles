let s:lines = luaeval("require('lines')")

function! sl#tabline()
  return s:lines["tabline"]()
endfunction

function! sl#statusline(current, width)
  return s:lines["statusline"](a:current, a:width)
endfunction

function! sl#gitstatus_hunks(idx)
  if !has_key(b:, 'gitgutter') || !has_key(b:gitgutter, 'summary')
    return 0
  endif

  return get(b:gitgutter['summary'], a:idx)
endfunction

function! sl#filename()
  return s:lines["components"]["buffer_filename"]()
endfunction

function! sl#diagnostic(d)
  return s:lines["components"]["buffer_diagnostics"](a:d)
endfunction
