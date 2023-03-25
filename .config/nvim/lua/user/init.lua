-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

pcall(require, 'user.before')

require('user.settings')
require('user.mappings')
require('user.plugins')

pcall(require, 'user.after')
