" lightline thigs
set noshowmode

if !has('gui_running')
  set t_Co=256
endif

let g:lightline = {
  \ 'colorscheme': 'srcery',
  \ 'enable': {
  \   'statusline': 1,
  \   'tabline': 0
  \ },
  \ 'active': {
  \   'left':  [ ['mode'],
  \              ['gitbranch'],
  \              ['filename', 'modified']],
  \   'right': [ ['percent', 'lineinfo', 'backjobs'],
  \              ['diagnostic']]
  \ },
  \ 'component_function': {
  \   'diagnostic': 'LightlineDiagnostic',
  \   'gitbranch': 'LightlineGitBranch',
  \   'filename': 'LightlineFileName',
  \   'backjobs': 'BackgroundJobs',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightlineDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})

  let errors = get(info, 'error', 0)
  let warnings = get(info, 'warning', 0)

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

  if errors + warnings == 0
    return ''
  else
    return status
  endif
endfunction

function! LightlineFileName() abort
  return winwidth(0) > 70 ? WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : ''
endfunction

function! LightlineGitBranch()
  if exists('*fugitive#head')
    let branch = fugitive#head(8)
    if branch !=# ''
      return ' '.branch
    endif
  endif
  return ''
endfunction

function! BackgroundJobs()
  if !exists('g:asyncrun_status')
    return ''
  elseif g:asyncrun_status == 'running'
    return 'running'
  elseif g:asyncrun_status == 'failure'
    return 'failed'
  else
    return ''
  endif
endfunction
