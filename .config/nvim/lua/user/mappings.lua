-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local bind = vim.keymap.set
local remap = {remap = true}

-- Wrapped lines {
  -- Make sure that movements work as expected in wrapped lines
  bind('', '<silent> j', 'gj')
  bind('', '<silent> k', 'gk')
  bind('', '<silent> 0', 'g0')
  bind('', '<silent> ^', 'g^')
  bind('', '<silent> $', 'g$')

  bind('', '<silent> gj', 'j')
  bind('', '<silent> gk', 'k')
  bind('', '<silent> g0', '0')
  bind('', '<silent> g^', '^')
  bind('', '<silent> g$', '$')
-- }

-- Creates bind('', 'pings for searching through quicklist', '{', remap)
  bind('', '[Q', '<cmd>cfirst<CR>')
  bind('', '[q', '<cmd>cprev<CR>')
  bind('', ']q', '<cmd>cnext<CR>')
  bind('', ']Q', '<cmd>clast<CR>')
-- }

-- Easier horizontal scrolling
bind('', 'zl', 'zL', remap)
bind('', 'zh', 'zH', remap)

-- tab bind('', 'pings', '{', remap)
  bind('', '<leader>tt', '<cmd>tabnew<cr>', remap)
  bind('', '<leader>te', ':tabedit', remap)
  bind('', '<leader>tc', '<cmd>tabclose<cr>', remap)
  bind('', '<leader>to', '<cmd>tabonly<cr>', remap)
  bind('', '<leader>tn', '<cmd>tabnext<cr>', remap)
  bind('', '<leader>tp', '<cmd>tabprevious<cr>', remap)
  bind('', '<leader>tf', '<cmd>tabfirst<cr>', remap)
  bind('', '<leader>tl', '<cmd>tablast<cr>', remap)
  bind('', '<leader>tm', ':tabmove', remap)
-- }

-- Code folding options {
  bind('n', '<leader>f0', '<cmd>set foldlevel=0<CR>', remap)
  bind('n', '<leader>f1', '<cmd>set foldlevel=1<CR>', remap)
  bind('n', '<leader>f2', '<cmd>set foldlevel=2<CR>', remap)
  bind('n', '<leader>f3', '<cmd>set foldlevel=3<CR>', remap)
  bind('n', '<leader>f4', '<cmd>set foldlevel=4<CR>', remap)
  bind('n', '<leader>f5', '<cmd>set foldlevel=5<CR>', remap)
  bind('n', '<leader>f6', '<cmd>set foldlevel=6<CR>', remap)
  bind('n', '<leader>f7', '<cmd>set foldlevel=7<CR>', remap)
  bind('n', '<leader>f8', '<cmd>set foldlevel=8<CR>', remap)
  bind('n', '<leader>f9', '<cmd>set foldlevel=9<CR>', remap)
-- }

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
bind('v', '. <cmd>normal', '.<CR>')

-- For when you forget to sudo.. Really Write the file.
bind('c', 'w!!', 'w !sudo tee %>/dev/null', remap)

-- Easier formatting
bind('n', '<silent> <leader>q', 'gwip')

-- Adjust viewports to the same size
bind('', '<leader>=', '<C-w>=', remap)

-- Shortcuts {
  -- Change Working Directory to that of the current file
  bind('c', 'cwd lcd', '%:p:h', remap)
  bind('c', 'cd. lcd', '%:p:h', remap)

  -- Visual shifting (does not exit Visual mode)
  bind('v', '<', '<gv')
  bind('v', '>', '>gv')
-- }

-- Some helpers to edit mode {
  -- Practical VIM and http://vimcasts.org/episodes/the-edit-command/
  bind('c', '<expr> %%', "getcmdtype() == ':' ? expand('%:h').'/' : '%%'")
  bind('', '<leader>ew', ':e %%', remap)
  bind('', '<leader>es', ':sp %%', remap)
  bind('', '<leader>ev', ':vsp %%', remap)
  bind('', '<leader>et', ':tabe %%', remap)
-- }

-- Most prefer to toggle search highlighting rather than clear the current
-- search results.
bind('n', '<silent> <leader>/', '<cmd>set invhlsearch<CR>', remap)

-- Find merge conflict markers
bind('', '<leader>fc', '/\\v^[<\\|=>]{7}(.*\\|$)<CR>', remap)

-- Yank from the cursor to the end of the line, to be consistent with C and D.
bind('n', 'Y', 'y$')

bind('i', 'jk', '<ESC>')

-- Neovim terminal escape bind('', 'ping', '{', remap)
  bind('t', '<Esc>', '<C-\\><C-n>')
  bind('t', 'jk', '<C-\\><C-n>')
  bind('t', '<C-v><Esc>', '<Esc>')
-- }
