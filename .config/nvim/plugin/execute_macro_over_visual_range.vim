" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Run macro in parallel over selected range (from Practical VIM, Tip 30) {
  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction"

  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
" }
