" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

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

    " neovim virtualenv executable
    let g:python3_host_prog = expand("$HOME/.virtualenvs/neovim/bin/python")
  " }

  " Basics {
    if &compatible
      set nocompatible
    endif

    set shell=/bin/bash
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 12
  " }

  " Arrow Key Fix {
    " http://vim.wikia.com/wiki/Fix_arrow_keys_that_display_A_B_C_D_on_remote_shell#Solution_21
    if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
      inoremap <silent> <C-[>OC <RIGHT>
    endif
  " }

  let g:tex_flavor = 'latex'

" }

" Setup minpac support {
  function! PackInit() abort
    packadd minpac
    call minpac#init()
    call minpac#add('k-takata/minpac', {'type': 'opt'})
    source $HOME/.config/nvim/plugins.vim
  endfunction

  function! PackList(...)
    call PackInit()
    return join(sort(keys(minpac#getpluglist())), "\n")
  endfunction

  " Add minpac commands" {
  command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
  command! PackClean  call PackInit() | call minpac#clean()
  command! PackStatus call PackInit() | call minpac#status()

  command! -nargs=1 -complete=custom,PackList
    \ PackOpenDir call PackInit() | call term_start(&shell,
    \  {'cwd': minpac#getpluginfo(<q-args>).dir, 'term_finish': 'close'})

  command! -nargs=1 -complete=custom,PackList
    \ PackOpenUrl call PackInit() | call openbrowser#open(
    \  minpac#getpluginfo(<q-args>).url)
  " }
" }

if filereadable(expand("$HOME/.vimrc_before"))
  source $HOME/.vimrc_before
endif


source $HOME/.config/nvim/basic-settings.vim
source $HOME/.config/nvim/navigation-mappings.vim
source $HOME/.config/nvim/editing-mappings.vim
source $HOME/.config/nvim/ex-commands.vim
packloadall
source $HOME/.config/nvim/plugin-config.vim
source $HOME/.config/nvim/autocommands.vim
source $HOME/.config/nvim/completion.vim

if filereadable(expand("$HOME/.vimrc_after"))
  source $HOME/.vimrc_after
endif

let test#strategy = "dispatch"

" GUI Settings {
  " GVIM- (here instead of .gvimrc)
  if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
    set guifont=Liberation\ Mono\ for\ Powerline\ 10,Menlo\ Regular\ 10,Consolas\ Regular\ 10,Courier\ New\ Regular\ 10
  else
    if &term == 'xterm' || &term == 'screen'
      set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
  endif
" }
