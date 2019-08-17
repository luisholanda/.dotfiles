let s:impulse_multiplier = g:comfortable_motion_impulse_multiplier * winheight(0)

function! motion#flick(multiplier)
  call comfortable_motion#flick(s:impulse_multiplier * a:multiplier)
endfunction
