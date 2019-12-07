function! sl#statusline(current, width)
  if !a:current
    return '%#CrystallieInactive# %f %= %l, %c '
  endif

  let l:s = '%#CrystallineFill# '
  let l:lsep = crystalline#left_sep('', 'Fill')
  let l:rsep = crystalline#right_sep('', 'Fill')
  let l:lmdsep = crystalline#left_mode_sep('Fill')
  let l:rmdsep = crystalline#right_mode_sep('Fill')

  let l:s .= ' ' . l:lmdsep . '%{sl#filetype_region()}' . l:rmdsep . ' '

  let l:s .= l:lsep . ' %{sl#gitbranch()} ' . l:rsep

  let l:s .= '%='

  let l:s .= l:lsep . ' %{sl#diagnostics()} ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %l, %c ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %P, %L ' . l:rsep

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

function! sl#filetype_region()
  if @% == ""
    if &modified
      return '[No Name ●]'
    else
      return '[No Name]'
    endif
  else
    if !exists("b:filename_with_icon")
       let b:filename_with_icon = system('echo "' . @% . '" | devicon-lookup | tr "\n" " "')
    endif

    let l:s = b:filename_with_icon

    if &modified
      let l:s .= ' ●'
    endif

    return l:s
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
