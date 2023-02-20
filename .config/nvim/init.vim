" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

runtime vimrc_before

lua require('user.settings')
runtime mappings.vim
runtime plugins.vim

runtime vimrc_after
