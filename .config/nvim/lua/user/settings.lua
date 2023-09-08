-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

-- neovim virtualenv executable
vim.g.python3_host_prog = vim.fn.expand("$HOME/.virtualenvs/neovim/bin/python")

vim.g.mapleader = ','
vim.g.maplocalleader = ';'

-- Having longer update time (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.wo.number = true                     -- Line numbers on
vim.wo.signcolumn = 'yes'

vim.o.clipboard = 'unnamedplus'

vim.opt.wildmode = {'list:longest', 'full'} -- Command <Tab> completion, list matches, then longest common part, then all.

vim.o.cursorline = true                   -- Highlight current line
vim.o.termguicolors = true

vim.o.breakindent = true
vim.o.showmatch = true                    -- Show matching brackets/parenthesis
vim.o.whichwrap = 'b,s,h,l,<,>,[,]'       -- Backspace and cursor keys wrap too

vim.opt.shortmess:append('mrc')           -- Abbrev. of messages (avoids 'hit enter')
vim.o.virtualedit = 'onemore'             -- Allow for cursor beyond last character
vim.o.completeopt = 'menuone,noselect'    -- Set completeopt to have a better completion experience

vim.o.conceallevel = 2
--
-- Split below by default
vim.o.splitbelow = true
-- Split right by default
vim.o.splitright = true

-- Search (
  vim.o.ignorecase = true                 -- Case insensitive search
  vim.o.smartcase = true                  -- Case sensitive when uc present
-- )

-- Formatting (
  vim.o.wrap = false                      -- Do not wrap long lines
  vim.o.scrolloff = 3                     -- Minimum lines to keep above and below cursor
  vim.o.list = true
  vim.opt.listchars = {                     -- Highlight problematic whitespace
    tab = '›\\ ',
    trail = '•',
    extends = '#',
    nbsp = '.',
  }
  --)

-- Backup and undo files (
vim.o.backup = true                     -- Backups are nice ...
vim.o.backupdir = vim.fn.expand("$HOME/.local/state/nvim/backup/")
vim.o.undofile = true
-- )

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
