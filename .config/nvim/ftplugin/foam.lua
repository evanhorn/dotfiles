-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local set = vim.opt

set.foldmethod = vim.fn.expr
set.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
set.foldminlines = 15
