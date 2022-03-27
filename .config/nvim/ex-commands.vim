" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Relative wrap motion {
  " End/Start of line motion keys act relative to row/wrap width in the
  " presence of `:set wrap`, and relative to line for `:set nowrap`.
  " Default vim behaviour is to act relative to text line in both cases
  " Same for 0, home, end, etc
  function! WrapRelativeMotion(key, ...)
    let vis_sel=""
    if a:0
      let vis_sel="gv"
    endif
    if &wrap
      execute "normal!" vis_sel . "g" . a:key
    else
      execute "normal!" vis_sel . a:key
    endif
  endfunction

  " Map g* keys in Normal, Operator-pending, and Visual+select
  noremap $ <cmd>call WrapRelativeMotion("$")<CR>
  noremap <End> <cmd>call WrapRelativeMotion("$")<CR>
  noremap 0 <cmd>call WrapRelativeMotion("0")<CR>
  noremap <Home> <cmd>call WrapRelativeMotion("0")<CR>
  noremap ^ <cmd>call WrapRelativeMotion("^")<CR>
  " Overwrite the operator pending $/<End> mappings from above
  " to force inclusive motion with :execute normal!
  onoremap $ v:call WrapRelativeMotion("$")<CR>
  onoremap <End> v:call WrapRelativeMotion("$")<CR>
  " Overwrite the Visual+select mode mappings from above
  " to ensure the correct vis_sel flag is passed to function
  vnoremap $ :<C-U>call WrapRelativeMotion("$", 1)<CR>
  vnoremap <End> :<C-U>call WrapRelativeMotion("$", 1)<CR>
  vnoremap 0 :<C-U>call WrapRelativeMotion("0", 1)<CR>
  vnoremap <Home> :<C-U>call WrapRelativeMotion("0", 1)<CR>
  vnoremap ^ :<C-U>call WrapRelativeMotion("^", 1)<CR>
" }

" Stupid shift key fixes {
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif
  cmap Tabe tabe
" }

" Shell command {
  function! s:RunShellCommand(cmdline)
    botright new

    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell

    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
  endfunction

  command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
" }

" Toggle background {
  function! ToggleBG()
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

  function! ToggleTransparent()
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

" Expand alias in Ex Mode {
  function! SetupCommandAlias(input, output)
    exec 'cabbrev <expr> '.a:input
          \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
          \ .'? ("'.a:output.'") : ("'.a:input.'"))'
  endfunction
" }

" Run macro in parallel over selected range (from Practical VIM, Tip 30) {
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction"
" }

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

augroup filetypedetect
  au! BufRead,BufNewFile *.geo setfiletype gmsh
  au! BufRead,BufNewFile *.pro setfiletype getdp
augroup END

augroup foam
  au FileType foam set foldmethod=expr
  au FileType foam set foldexpr=nvim_treesitter#foldexpr()
  " Only fold more than 15 lines
  au FileType foam set foldminlines=15
augroup END
