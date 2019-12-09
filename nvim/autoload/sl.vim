let s:curr_label = 'TabSel'
let s:last_label = 'ReplaceMode'
let s:shown_label = 'InsertMode'
let s:unshown_label = 'Tab'
let s:fill_label = 'TabFill'

let s:bl_sep_cache = {}

function! s:bl_sep(last_status, curr_status)
  if a:last_status == a:curr_status
    return ''
  else
    return s:bl_sep_cache[a:last_status . ' ' . a:curr_status]
  endif
endfunction

function! s:build_bl_sep_cache()
  if len(s:bl_sep_cache) != 0
    return
  endif

  let l:c_to_s_sep = crystalline#right_sep(s:curr_label, s:shown_label)
  let l:c_to_l_sep = crystalline#right_sep(s:curr_label, s:last_label)
  let l:c_to_u_sep = crystalline#right_sep(s:curr_label, s:unshown_label)
  let l:c_to_f_sep = crystalline#right_sep(s:curr_label, s:fill_label)

  let l:s_to_c_sep = crystalline#right_sep(s:shown_label, s:curr_label)
  let l:s_to_l_sep = crystalline#right_sep(s:shown_label, s:last_label)
  let l:s_to_u_sep = crystalline#right_sep(s:shown_label, s:unshown_label)
  let l:s_to_f_sep = crystalline#right_sep(s:shown_label, s:fill_label)

  let l:u_to_c_sep = crystalline#right_sep(s:unshown_label, s:curr_label)
  let l:u_to_l_sep = crystalline#right_sep(s:unshown_label, s:last_label)
  let l:u_to_s_sep = crystalline#right_sep(s:unshown_label, s:shown_label)
  let l:u_to_f_sep = crystalline#right_sep(s:unshown_label, s:fill_label)

  let l:l_to_c_sep = crystalline#right_sep(s:unshown_label, s:curr_label)
  let l:l_to_s_sep = crystalline#right_sep(s:unshown_label, s:shown_label)
  let l:l_to_u_sep = crystalline#right_sep(s:unshown_label, s:last_label)
  let l:l_to_f_sep = crystalline#right_sep(s:unshown_label, s:fill_label)

  " 0 - unshown, 1 - shown, 2 - current, 3 - fill, 4 - last
  let s:bl_sep_cache = {
        \'0 1': l:u_to_s_sep,
        \'0 2': l:u_to_c_sep,
        \'0 3': l:u_to_f_sep,
        \'0 4': l:u_to_l_sep,
        \'1 0': l:s_to_u_sep,
        \'1 2': l:s_to_c_sep,
        \'1 3': l:s_to_f_sep,
        \'1 4': l:s_to_l_sep,
        \'2 0': l:c_to_u_sep,
        \'2 1': l:c_to_s_sep,
        \'2 3': l:c_to_f_sep,
        \'2 4': l:c_to_l_sep,
        \'4 0': l:l_to_u_sep,
        \'4 1': l:l_to_s_sep,
        \'4 2': l:l_to_c_sep,
        \'4 3': l:l_to_f_sep,
        \}
endfunction

function! sl#bufferline()
  call s:build_bl_sep_cache()

  let l:tablabel = 'crystalline#default_tablabel'
  let l:tabwidth = crystalline#default_tabwidth()
  let l:pad = 10

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
      let l:buf_status == 2
    endif

    let l:s .= s:bl_sep(l:last_buf_status, l:buf_status) . ' ' . s:filename_region(l:buf)

    let l:last_buf_status = l:buf_status
  endfor

  let l:s .= s:bl_sep(l:last_buf_status, 3) . '%='

  let l:gb_l_sep = crystalline#left_sep('TabType', 'TabFill')
  let l:gb_r_sep = crystalline#right_sep('TabType', 'TabFill')
  let l:s .=  l:gb_l_sep . ' %{sl#gitbranch()} ' . l:gb_r_sep

  return l:s
endfunction

function! sl#statusline(current, width)
  if !a:current
    return ' %f %= %l, %c '
  endif

  let l:s = '%#CrystallineFill#'
  let l:lsep = crystalline#left_sep('', 'Fill')
  let l:rsep = crystalline#right_sep('', 'Fill')
  let l:lmdsep = crystalline#left_mode_sep('Fill')
  let l:rmdsep = crystalline#right_mode_sep('Fill')

  let l:s .= l:lmdsep . crystalline#mode_label() . l:rmdsep
  let l:s .= ' ' . l:lsep . s:gitstatus_region() . l:rsep
  let l:s .= ' ' . l:lsep . ' %{sl#diagnostics()} ' . l:rsep

  let l:s .= '%='

  let l:s .= l:lsep . ' %l, %c ' . l:rsep
  let l:s .= ' '

  let l:s .= l:lsep . ' %P, %L ' . l:rsep

  return l:s
endfunction

function! sl#gitbranch()
  if exists('*fugitive#head')
    let l:repo = s:repository_name()
    if l:repo !=# ''
      let l:branch = fugitive#head(8)
      if l:branch !=# ''
        return l:repo . ' (' . l:branch . ') '
      endif

    endif
  endif

  return 'Not Versioned'
endfunction

function! s:repository_name()
  if !has_key(b:, 'reponame')
    let l:url = fugitive#RemoteUrl()
    let l:user = fnamemodify(fnamemodify(l:url, ':h'), ':t')
    let l:repo = fnamemodify(l:url, ':t:r')

    let b:reponame = l:user . '/' . l:repo
  endif

  return b:reponame
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
      let l:name = fnamemodify(l:name, ':.')
      let a:buf['variables']['filename_with_icon'] = system('echo "' . l:name . '" | devicon-lookup | tr "\n" " "')[:-1]
    endif

    let l:s = a:buf['variables']['filename_with_icon']

    if l:modified
      let l:s .= ' ●'
    endif

    return l:s
endfunction

function! s:gitstatus_region()
  let [l:added, l:changed, l:deleted] = get(get(b:, 'gitgutter', {}), 'summary', [0, 0, 0])

  return '%#CrystallineVisualMode#  ' . l:added . ' %#CrystallineTabType# ' . l:changed . ' %#CrystallineReplaceMode# ' . l:deleted . ' '
endfunction
