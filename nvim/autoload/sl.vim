function! sl#statusline(current, width)
  if !a:current
    return '%#CrystallieInactive# %f %= %l, %c '
  endif

  let l:s = '%#CrystallineFill# '
  let l:lmdsep = crystalline#left_mode_sep('Fill')
  let l:rmdsep = crystalline#right_mode_sep('Fill')
  let l:lsep = crystalline#left_sep('', 'Fill')
  let l:rsep = crystalline#right_sep('', 'Fill')

  let l:s .= l:lmdsep . ' %{WebDevIconsGetFileTypeSymbol()} %f '

  if &modified
    let l:s .= ' ● '
  endif

  let l:s .= l:rmdsep

  let l:s .= ' '

  let l:s .= l:lsep . ' %{sl#gitbranch()} ' . l:rsep

  let l:s .= '%='

  let l:s .= l:lsep . ' %{sl#diagnostics()} ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %l, %c ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %P, %L ' . l:rsep

  " if a:width > 80
  "   let l:s .= ' ' . l:lmdsep . '%{sl#filetype()}' . ' ' . l:rmdsep
  " endif

  return l:s . ' '
endfunction

function! sl#gitbranch()
  if exists('*fugitive#head')
    let branch = fugitive#head(8)
    if branch !=# ''
      return ' '.branch
    endif
  endif

  return ''
endfunction

function! sl#filetype()
  return WebDevIconsGetFileTypeSymbol() . ' ' . &filetype
endfunction

function! sl#diagnostics()
  let info = get(b:, 'coc_diagnostic_info', {})

  let errors = get(info, 'error', 0)
  let warnings = get(info, 'warning', 0)

  if errors + warnings == 0
    return ''
  endif

  let status = ''
  if errors > 0
    let status .= '' . string(errors)

    if warnings > 0
      let status .= ' '
    endif
  endif

  if warnings > 0
    let status .= '' . string(warnings)
  endif

  return status
endfunction
