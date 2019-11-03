function! hooks#plugins#comfortable_motion()
  let g:comfortable_motion_no_default_key_mappings = 1
  let g:comfortable_motion_impulse_multiplier = 1
endfunction

function! hooks#plugins#easymotion()
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_prompt = "Jump to →"
  let g:EasyMotion_keys = "fjdkswbeoavn"
  let g:EasyMotion_smartcase = 1
  let g:EasyMotion_use_smartsign_us = 1
endfunction

function! hooks#plugins#gitgutter()
  let g:gitgutter_map_keys = 0
  let g:gitgutter_sign_added =  '┃'
  let g:gitgutter_sign_modified = '┃'
  let g:gitgutter_sign_removed = '◢'
  let g:gitgutter_sign_removed_first_line = '◥'
  let g:gitgutter_sign_modified_removed = '◢'
  let g:gitgutter_override_sign_column_highlight = 0
endfunction

function! hooks#plugins#rust()
  let g:rust_fold = 2
  let g:rustfmt_autosave_if_config_present = 1
endfunction

function! hooks#plugins#crystalline()
  let g:crystalline_enable_sep = 1
  let g:crystalline_separators = ['', '']
  let g:crystalline_statusline_fn = 'sl#statusline'
  let g:crystalline_theme = 'snow_dark'
endfunction

function! hooks#plugins#webdevicons()
  let g:webdevicons_enable_nerdtree = 0
  let g:webdevicons_enable_unite = 0
  let g:webdevicons_enable_vimfiler = 0
  let g:webdevicons_enable_airline_tabline = 0
  let g:webdevicons_enable_airline_statusline = 0
  let g:webdevicons_enable_ctrlp = 0
  let g:webdevicons_enable_startify = 0
  let g:webdevicons_enable_flagship_statusline = 0
  let g:webdevicons_enable_denite = 0
endfunction
