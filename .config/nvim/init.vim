" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Environment {

  " Identify platform {
    silent function! OSX()
      return has('macunix')
    endfunction
    silent function! LINUX()
      return has('unix') && !has('macunix') && !has('win32unix')
    endfunction
    silent function! WINDOWS()
      return  (has('win32') || has('win64'))
    endfunction
  " }

  " neovim virtualenv executable
  let g:python3_host_prog = expand("$HOME/.virtualenvs/neovim/bin/python")

  " Basics {
    if &compatible
      set nocompatible
    endif

    set shell=/bin/bash
  " }

  " Arrow Key Fix {
    " http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell#Solution_21
    if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
      inoremap <silent> <C-[>OC <RIGHT>
    endif
  "}

" }

runtime vimrc_before

runtime basic-settings.vim
runtime mappings.vim
runtime ex-commands.vim
runtime plugins.vim

runtime vimrc_after
