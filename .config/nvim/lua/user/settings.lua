-- vim: set foldmarker=(,) foldlevel=0 foldmethod=marker spell:

-- neovim virtualenv executable
vim.g.python3_host_prog = vim.fn.expand("$HOME/.virtualenvs/neovim/bin/python")

local set = vim.opt

set.background = 'dark'                 -- Assume a dark background

vim.g.mapleader = ','
vim.g.maplocalleader = ';'

vim.cmd [[filetype plugin indent on]]   -- Automatically detect file types.

set.cmdheight = 2                       -- Give more space for displaying messages.

-- Having longer update time (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
set.updatetime = 100

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
set.signcolumn = 'number'

set.wildmode = {'list:longest', 'full'} -- Command <Tab> completion, list matches, then longest common part, then all.

set.pastetoggle = '<F12>'

set.cursorline = true                   -- Highlight current line
set.termguicolors = true

set.showmatch = true                    -- Show matching brackets/parenthesis

set.whichwrap = 'b,s,h,l,<,>,[,]'      -- Backspace and cursor keys wrap too

set.shortmess:append('mrc')             -- Abbrev. of messages (avoids 'hit enter')
set.virtualedit = 'onemore'             -- Allow for cursor beyond last character

set.conceallevel = 2
--
-- Split below by default
set.splitbelow = true
-- Split right by default
set.splitright = true

if vim.fn.executable('nvr') then
  vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

vim.cmd [[highlight! link TermCursor Cursor]]
vim.cmd [[highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15]]

-- Search (
  set.ignorecase = true                 -- Case insensitive search
  set.smartcase = true                  -- Case sensitive when uc present
  set.number = true                     -- Line numbers on
  -- set.path:append('app/**')             -- Add all subdirectories to search
-- )

-- Formatting (
  set.wrap = false                      -- Do not wrap long lines
  set.scrolljump = 5                    -- Lines to scroll when cursor leaves screen
  set.scrolloff = 3                     -- Minimum lines to keep above and below cursor
  set.list = true
  set.listchars = {                     -- Highlight problematic whitespace
    tab = '›\\ ',
    trail = '•',
    extends = '#',
    nbsp = '.',
  }
  --)

-- Cliboard settings (
if vim.fn.has('clipboard') then
  set.clipboard = 'unnamed'
  if vim.fn.has('unnamedplus') then     -- When possible use + register for copy-paste
      set.clipboard:append('unnamedplus')
  end
end
-- )

-- Backup and undo files (
  set.backup = true                     -- Backups are nice ...
  set.backupdir = vim.fn.expand("$HOME/.local/state/nvim/backup/")
  vim.cmd [[set backupdir=$HOME/.local/state/nvim/backup/]]
  if vim.fn.has('persistent_undo') then
    set.undofile = true
  end
-- )
