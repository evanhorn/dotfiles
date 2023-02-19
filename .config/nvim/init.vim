" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

runtime vimrc_before

" Backup and undo files {
  set backup                  " Backups are nice ...
  set backupdir=$HOME/.local/state/nvim/backup/
  if has('persistent_undo')
    set undofile
  endif
" }

" neovim virtualenv executable
let g:python3_host_prog = expand("$HOME/.virtualenvs/neovim/bin/python")

runtime basic-settings.vim
runtime mappings.vim
runtime plugins.vim

runtime vimrc_after
