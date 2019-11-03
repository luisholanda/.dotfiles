function! crystalline#theme#snow_dark#set_theme() abort
  let l:gry0 = [ "#2c2d30", 236 ]
  let l:gry1 = [ "#363a3e", 237 ]
  let l:gry3 = [ "#afb7c0", 249 ]
  let l:red  = [ "#be868c", 138 ]
  let l:mgnt = [ "#a88cb3", 139 ]
  let l:gren = [ "#7f9d77", 108 ]
  let l:blue = [ "#759abd", 110 ]

  call crystalline#generate_theme({
        \ 'NormalMode':  crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ 'InsertMode':  crystalline#theme#snow_dark#generate_group(l:blue, l:gry1),
        \ 'VisualMode':  crystalline#theme#snow_dark#generate_group(l:gren, l:gry1),
        \ 'ReplaceMode': crystalline#theme#snow_dark#generate_group(l:red, l:gry1),
        \ '':            crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ 'Inactive':    crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ 'Fill':        crystalline#theme#snow_dark#generate_group(l:gry3, l:gry0),
        \ 'Tab':         crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ 'TabType':     crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ 'TabSel':      crystalline#theme#snow_dark#generate_group(l:gry0, l:gren),
        \ 'TabFill':     crystalline#theme#snow_dark#generate_group(l:gry3, l:gry1),
        \ })
endfunction


function! crystalline#theme#snow_dark#generate_group(group1, group2)
  return [[a:group1[1], a:group2[1]], [a:group1[0], a:group2[0]]]
endfunction
