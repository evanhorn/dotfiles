-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

local set = vim.opt
local bind = vim.keymap.set
local remap = {remap = true}

-- Ctags {
  set.tags = {'./tags;/', '$HOME/.local/share/nvim/vimtags'}

  vim.cmd [[
  " Make tags placed in .git/tags file available in all levels of a repository
  let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
  if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
  endif
  ]]
-- }

-- Misc {
  vim.b.match_ignorecase = 1
  vim.g['test#strategy'] = "dispatch"
-- }

vim.cmd [[runtime plugin-config-local.vim]]
