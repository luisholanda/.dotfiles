let s:curr_label = 'TabSel'
let s:last_label = 'ReplaceMode'
let s:shown_label = 'InsertMode'
let s:unshown_label = 'Tab'
let s:fill_label = 'TabFill'

let s:bl_sep_cache = {}

function! s:bl_sep(last_status, curr_status)
  return s:bl_sep_cache[a:last_status . a:curr_status]
endfunction

function! s:same_sep(left_label, right_label)
  return '%#Crystalline' . a:left_label . '#%#CrystallineTab#%#Crystalline' . a:right_label . '#'
endfunction

function! s:build_bl_sep_cache()
  if len(s:bl_sep_cache) != 0
    return
  endif

  " 0 - unshown, 1 - shown, 2 - current, 3 - fill, 4 - last
  let s:bl_sep_cache = {
        \'00': s:same_sep(s:unshown_label, s:unshown_label),
        \'01': s:same_sep(s:unshown_label, s:shown_label),
        \'02': crystalline#right_sep(s:unshown_label, s:curr_label),
        \'03': crystalline#right_sep(s:unshown_label, s:fill_label),
        \'04': s:same_sep(s:unshown_label, s:last_label),
        \
        \'10': s:same_sep(s:shown_label, s:unshown_label),
        \'11': s:same_sep(s:shown_label, s:shown_label),
        \'12': crystalline#right_sep(s:shown_label, s:curr_label),
        \'13': crystalline#right_sep(s:shown_label, s:fill_label),
        \'14': s:same_sep(s:shown_label, s:last_label),
        \
        \'20': crystalline#right_sep(s:curr_label, s:unshown_label),
        \'21': crystalline#right_sep(s:curr_label, s:shown_label),
        \'23': crystalline#right_sep(s:curr_label, s:fill_label),
        \'24': crystalline#right_sep(s:curr_label, s:last_label),
        \
        \'40': s:same_sep(s:last_label, s:last_label),
        \'41': s:same_sep(s:last_label, s:shown_label),
        \'42': crystalline#right_sep(s:last_label, s:curr_label),
        \'43': crystalline#right_sep(s:last_label, s:fill_label),
        \'44': s:same_sep(s:last_label, s:last_label),
        \}
endfunction

function! sl#bufferline()
  call s:build_bl_sep_cache()

  let l:curbuf = bufnr('%')
  let l:lastbuf = bufnr('#')
  let l:buffers = s:list_buffers()

  let l:curr_dir = ' '. fnamemodify(getcwd(), ':~')
  let l:s = crystalline#left_sep('Tab', 'TabFill') . l:curr_dir . crystalline#right_sep('Tab', 'TabFill')

  let l:s .= ' ' . crystalline#left_sep('Tab', 'TabFill') . 'ﯟ'

  let l:last_buf_status = 0

  for l:buf in l:buffers
    let l:buf_status = s:is_shown(l:buf) + s:is_same(l:buf, l:curbuf) + 4 * s:is_same(l:buf, l:lastbuf)
    if l:buf_status == 5
      let l:buf_status = 4
    elseif l:buf_status == 6
      let l:buf_status = 2
    endif

    let l:s .= s:bl_sep(l:last_buf_status, l:buf_status) . ' ' . s:filename_region(l:buf)

    let l:last_buf_status = l:buf_status
  endfor

  let l:s .= s:bl_sep(l:last_buf_status, 3) . '%='

  let l:gb_l_sep = crystalline#left_sep('TabType', 'TabFill')
  let l:gb_r_sep = crystalline#right_sep('TabType', 'TabFill')

  return l:s
endfunction

function! sl#statusline(current, width)
  if !a:current
    return ' %f %#CrystallineVisualMode#  %{sl#gitstatus_hunks(0)} %#CrystallineTabType# %{sl#gitstatus_hunks(1)} %#CrystallineReplaceMode# %{sl#gitstatus_hunks(2)} %#Crystalline# %= %l, %c '
  elseif has_key(b:, 'statusline')
    if mode() ==# get(b:, 'last_mode', '')
      return b:statusline
    endif
  endif

  let b:statusline = s:construct_statusline()
  let b:last_mode = mode()

  return b:statusline
endfunction

function! s:construct_statusline()
  let l:lsep = crystalline#left_sep('', 'Fill')
  let l:rsep = crystalline#right_sep('', 'Fill')
  let l:lmdsep = crystalline#left_mode_sep('Fill')
  let l:rmdsep = crystalline#right_mode_sep('Fill')

  let l:s = '%#CrystallineFill#'
  let l:s .= l:lmdsep . crystalline#mode_label() . l:rmdsep
  let l:s .= ' ' . l:lsep . '%#CrystallineVisualMode#  %{sl#gitstatus_hunks(0)} %#CrystallineTabType# %{sl#gitstatus_hunks(1)} %#CrystallineReplaceMode# %{sl#gitstatus_hunks(2)} ' . l:rsep
  let l:s .= ' ' . l:lsep . ' %{sl#diagnostics()} ' . l:rsep

  let l:s .= '%='

  let l:s .= l:lsep . ' %l, %c ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %P, %L ' . l:rsep

  return l:s
endfunction

function! sl#gitstatus_hunks(idx)
  if !has_key(b:, 'gitgutter') || !has_key(b:gitgutter, 'summary')
    return 0
  endif

  return get(b:gitgutter['summary'], a:idx)
endfunction

function! sl#current_filename_region()
  return s:filename_region(getbufinfo(bufnr('%'))[0])
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


function! s:list_buffers()
  let l:maxbufs = crystalline#calculate_max_tabs(2, 1, 4, 1)

  return getbufinfo({ 'buflisted': 1 })[:l:maxbufs]
endfunction

function! s:is_shown(buf)
  return len(a:buf.windows) != 0
endfunction

function! s:is_same(buf, buf_nr)
  return a:buf.bufnr == a:buf_nr
endfunction

function! s:filename_region(buf)
  let l:name = a:buf['name']
  let l:modified = a:buf['changed']

  if l:name == ""
    if l:modified
      return 'No Name ●'
    else
      return 'No Name'
    endif
  else
    if !has_key(a:buf['variables'], 'filename_with_icon')
      let l:name = pathshorten(fnamemodify(l:name, ':.'))
      let a:buf['variables']['filename_with_icon'] = system('echo "' . l:name . '" | devicon-lookup | tr "\n" " "')[:-1]
    endif

    let l:s = a:buf['variables']['filename_with_icon']

    if l:modified
      let l:s .= ' ●'
    endif

    return l:s
  endif
endfunction
