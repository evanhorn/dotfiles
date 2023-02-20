" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

runtime vimrc_before

lua require('user.settings')
lua require('user.mappings')
runtime plugins.vim

runtime vimrc_after
