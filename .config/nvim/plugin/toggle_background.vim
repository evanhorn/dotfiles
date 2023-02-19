" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

function ToggleBG()
  let s:is_transparent = 0
  let s:tbg = &background
  " Inversion
  if s:tbg == "dark"
    set background=light
  elseif s:tbg == "light"
    set background=dark
  endif
endfunction

let s:is_transparent = 0

function ToggleTransparent()
  if s:is_transparent == 0
    set background=dark
    hi Normal guibg=NONE ctermbg=NONE
    let s:is_transparent = 1
  else
    let s:is_transparent = 0
    let s:tbg = &background
    if s:tbg == "dark"
      set background=dark
    elseif s:tbg == "light"
      set background=light
    endif
  endif
endfunction

noremap <localleader>bg <cmd>call ToggleBG()<CR>
noremap <localleader>tr <cmd>call ToggleTransparent()<CR>
" }
