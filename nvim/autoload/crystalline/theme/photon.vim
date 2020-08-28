function! crystalline#theme#photon#set_theme() abort
  let l:gry0 = [ "#262626", 235 ]
  let l:gry1 = [ "#303030", 236 ]
  let l:gry3 = [ "#767676", 243 ]
  let l:red  = [ "#af5f87", 132 ]
  let l:mgnt = [ "#af87d7", 140 ]
  let l:gren = [ "#87af87", 108 ]
  let l:blue = [ "#4484d1", 68 ]
  let l:gold = [ "#d7af5f", 179 ]

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
        \ })
endfunction

function! s:generate_group(group1, group2)
  return [[a:group1[1], a:group2[1]], [a:group1[0], a:group2[0]]]
endfunction
