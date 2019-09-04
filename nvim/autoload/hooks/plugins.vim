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
