function! crystalline#theme#xcodewwdc#set_theme() abort
  let l:gry0 = [ "#292c36", 17 ]
  let l:gry1 = [ "#494d5c", 59 ]
  let l:gry3 = [ "#b3b6c0", 145 ]
  let l:red  = [ "#bb383a", 131 ]
  let l:mgnt = [ "#b9b5f6", 147 ]
  let l:gren = [ "#c7faa4", 193 ]
  let l:blue = [ "#4484d1", 68 ]
  let l:gold = [ "#d28e5d", 173 ]

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
