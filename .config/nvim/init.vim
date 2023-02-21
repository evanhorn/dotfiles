" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

runtime vimrc_before

lua require('user.settings')
lua require('user.mappings')
lua require('user.plugins')

runtime vimrc_after
