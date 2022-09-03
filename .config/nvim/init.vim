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

if filereadable(expand("$HOME/.vimrc_before"))
  source $HOME/.vimrc_before
endif

source $HOME/.config/nvim/basic-settings.vim
source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/ex-commands.vim
source $HOME/.config/nvim/plugins.vim

if filereadable(expand("$HOME/.vimrc_after"))
  source $HOME/.vimrc_after
endif
