function! crystalline#theme#meh#set_theme() abort
  let l:gry0 = [ "#202022", 235 ]
  let l:gry1 = [ "#494d5c", 59 ]
  let l:gry3 = [ "#aaaaaa", 235 ]
  let l:red  = [ "#dd7766", 172 ]
  let l:mgnt = [ "#cc99cc", 139 ]
  let l:gren = [ "#77aa88", 193 ]
  let l:blue = [ "#88aaee", 110 ]
  let l:gold = [ "#ddaa66", 173 ]

  call crystalline#generate_theme({
        \ 'NormalMode':   s:generate_group(l:gry3, l:gry1),
        \ 'InsertMode':   s:generate_group(l:gry0, l:blue),
        \ 'VisualMode':   s:generate_group(l:gry0, l:gren),
        \ 'ReplaceMode':  s:generate_group(l:gry0, l:red),
        \ '':             s:generate_group(l:gry3, l:gry1),
        \ 'Inactive':     s:generate_group(l:gry3, l:gry1),
        \ 'Fill':         s:generate_group(l:gry3, l:gry0),
        \ 'Tab':          s:generate_group(l:gry3, l:gry1),
        \ 'TabType':      s:generate_group(l:gold, l:gry1),
        \ 'TabSel':       s:generate_group(l:gry0, l:mgnt),
        \ 'TabFill':      s:generate_group(l:gry3, l:gry0),
        \ 'GitAdd':       s:generate_group(l:gren, l:gry1),
        \ 'GitChng':      s:generate_group(l:gold, l:gry1),
        \ 'GitDel':       s:generate_group(l:red, l:gry1),
        \ 'DiagHint':     s:generate_group(l:blue, l:gry1),
        \ 'DiagWarn':     s:generate_group(l:gold, l:gry1),
        \ 'DiagError':    s:generate_group(l:red, l:gry1),
        \ 'LspMsgs':      s:generate_group(l:gry0, l:gry3)
        \ })
endfunction

function! s:generate_group(group1, group2)
  return [[a:group1[1], a:group2[1]], [a:group1[0], a:group2[0]]]
endfunction
