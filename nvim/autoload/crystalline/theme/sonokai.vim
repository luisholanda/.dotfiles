function! crystalline#theme#sonokai#set_theme() abort
  let l:gry0 = [ "#2b2d3a", 235 ]
  let l:gry1 = [ "#363a4e", 236 ]
  let l:gry3 = [ "#E1E3E4", 250 ]
  let l:red  = [ "#55393d", 52 ]
  let l:mgnt = [ "#bb97ee", 176 ]
  let l:gren = [ "#394634", 22 ]
  let l:blue = [ "#354157", 17 ]
  let l:gold = [ "#4e432f", 54 ]

  let l:pill_bg = l:gry3
  let l:pill_fg = l:gry1

  call crystalline#generate_theme({
        \ 'NormalMode':   s:generate_group(l:pill_bg, l:pill_fg),
        \ 'InsertMode':   s:generate_group(l:pill_bg, l:blue),
        \ 'VisualMode':   s:generate_group(l:pill_bg, l:gren),
        \ 'ReplaceMode':  s:generate_group(l:pill_bg, l:red),
        \ '':             s:generate_group(l:pill_fg, l:pill_bg),
        \ 'Inactive':     s:generate_group(l:gry3, l:gry1),
        \ 'Fill':         s:generate_group(l:gry3, l:gry0),
        \ 'Tab':          s:generate_group(l:pill_fg, l:pill_bg),
        \ 'TabType':      s:generate_group(l:gold, l:gry1),
        \ 'TabSel':       s:generate_group(l:gry0, l:mgnt),
        \ 'TabFill':      s:generate_group(l:gry3, l:gry0),
        \ 'GitAdd':       s:generate_group(l:gren, l:pill_bg),
        \ 'GitChng':      s:generate_group(l:gold, l:pill_bg),
        \ 'GitDel':       s:generate_group(l:red, l:pill_bg),
        \ 'DiagHint':     s:generate_group(l:blue, l:pill_bg),
        \ 'DiagWarn':     s:generate_group(l:gold, l:pill_bg),
        \ 'DiagError':    s:generate_group(l:red, l:pill_bg),
        \ 'LspMsgs':      s:generate_group(l:gry0, l:pill_bg)
        \ })
endfunction

function! s:generate_group(group1, group2)
  return [[a:group1[1], a:group2[1]], [a:group1[0], a:group2[0]]]
endfunction
