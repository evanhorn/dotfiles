-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local bind = vim.keymap.set

-- Wrapped lines {
  -- Make sure that movements work as expected in wrapped lines
  bind({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
  bind('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  bind('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
  bind('n', '0', "v:count == 0 ? 'g0' : '0'", { expr = true, silent = true })
  bind('n', '^', "v:count == 0 ? 'g^' : '^'", { expr = true, silent = true })
  bind('n', '$', "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
-- }

-- Creates bind('', 'pings for searching through quicklist', '{', { remap = true })
  bind('', '[Q', '<cmd>cfirst<CR>', { desc = 'Quickfix: First Item' })
  bind('', '[q', '<cmd>cprev<CR>', { desc = 'Quickfix: Previous Item' })
  bind('', ']q', '<cmd>cnext<CR>', { desc = 'Quickfix: Next Item' })
  bind('', ']Q', '<cmd>clast<CR>', { desc = 'Quickfix: Last Item' })
-- }

-- Easier horizontal scrolling {
bind('', 'zl', 'zL', { remap = true, desc = 'Scroll Right' })
bind('', 'zh', 'zH', { remap = true, desc = 'Scroll Left' })
-- }

-- tab bind('', 'pings', '{', { remap = true })
  bind('', '<leader>tt', '<cmd>tabnew<cr>', { remap = true, desc = 'New Empty Tab' })
  bind('', '<leader>te', ':tabedit', { remap = true, desc = '[T]ab [E]dit' })
  bind('', '<leader>tc', '<cmd>tabclose<cr>', { remap = true, desc = '[T]ab [C]lose' })
  bind('', '<leader>to', '<cmd>tabonly<cr>', { remap = true, desc = '[T]ab [O]nly' })
  bind('', '<leader>tn', '<cmd>tabnext<cr>', { remap = true, desc = '[T]ab [N]ext' })
  bind('', '<leader>tp', '<cmd>tabprevious<cr>', { remap = true, desc = '[T]ab [P]revious' })
  bind('', '<leader>tf', '<cmd>tabfirst<cr>', { remap = true, desc = '[T]ab [F]irst' })
  bind('', '<leader>tl', '<cmd>tablast<cr>', { remap = true, desc = '[T]ab [L]ast' })
  bind('', '<leader>tm', ':tabmove', { remap = true, desc = '[T]ab [M]ove'})
-- }

-- Code folding options {
  bind('n', '<leader>f0', '<cmd>set foldlevel=0<CR>', { remap = true, desc = 'Set [F]oldlevel 0' })
  bind('n', '<leader>f1', '<cmd>set foldlevel=1<CR>', { remap = true, desc = 'Set [F]oldlevel 1' })
  bind('n', '<leader>f2', '<cmd>set foldlevel=2<CR>', { remap = true, desc = 'Set [F]oldlevel 2' })
  bind('n', '<leader>f3', '<cmd>set foldlevel=3<CR>', { remap = true, desc = 'Set [F]oldlevel 3' })
  bind('n', '<leader>f4', '<cmd>set foldlevel=4<CR>', { remap = true, desc = 'Set [F]oldlevel 4' })
  bind('n', '<leader>f5', '<cmd>set foldlevel=5<CR>', { remap = true, desc = 'Set [F]oldlevel 5' })
  bind('n', '<leader>f6', '<cmd>set foldlevel=6<CR>', { remap = true, desc = 'Set [F]oldlevel 6' })
  bind('n', '<leader>f7', '<cmd>set foldlevel=7<CR>', { remap = true, desc = 'Set [F]oldlevel 7' })
  bind('n', '<leader>f8', '<cmd>set foldlevel=8<CR>', { remap = true, desc = 'Set [F]oldlevel 8' })
  bind('n', '<leader>f9', '<cmd>set foldlevel=9<CR>', { remap = true, desc = 'Set [F]oldlevel 9' })
-- }

-- Allow using the repeat operator with a visual selection (!)
-- http://stackoverflow.com/a/8064607/127816
bind('v', '. <cmd>normal', '.<CR>', { desc = 'Allow repeat operator with visual selection' })

-- For when you forget to sudo.. Really Write the file.
bind('c', 'w!!', 'w !sudo tee %>/dev/null', { remap = true, desc = 'Write with SUDO Permissions' })

-- Easier formatting
bind('n', '<leader>q', 'gwip', { silent = true, desc = 'Format Text Paragraph' })

-- Shortcuts {
  -- Change Working Directory to that of the current file
  bind('c', 'cwd lcd', '%:p:h', { remap = true, desc = 'Change working directory to current file directory' })
  bind('c', 'cd. lcd', '%:p:h', { remap = true, desc = 'Change working directory to current file directory' })

  -- Visual shifting (does not exit Visual mode)
  bind('v', '<', '<gv', { desc = 'Visual Mode Shift Left' })
  bind('v', '>', '>gv', { desc = 'Visual Mode Shift Right' })
-- }

-- Some helpers to edit mode {
  -- Practical VIM and http://vimcasts.org/episodes/the-edit-command/
  bind('c', '%%', "<C-R>=fnameescape(expand('%:h')).'/'<CR>", { desc = 'Expand Current File Directory' })
  bind('', '<leader>ew', ':e %%', { remap = true, desc = '[E]dit [W]indow-Current Directory' })
  bind('', '<leader>es', ':sp %%', { remap = true, desc = '[E]dit [S]plit-Current Directory' })
  bind('', '<leader>ev', ':vsp %%', { remap = true, desc = '[E]dit [V]ert [S]plit-Current Directory' })
  bind('', '<leader>et', ':tabe %%', { remap = true, desc = '[E]dit [T]ab-Current Directory' })
-- }

-- Most prefer to toggle search highlighting rather than clear the current
-- search results.
bind('n', '<leader>/', '<cmd>set invhlsearch<CR>', { silent = true, remap = true, desc = 'Toggle Search Highlight' })

-- Find merge conflict markers
bind('', '<leader>fc', '/\\v^[<\\|=>]{7}(.*\\|$)<CR>', { remap = true, desc = 'Find merge conflict markers' })

-- Yank from the cursor to the end of the line, to be consistent with C and D.
bind('n', 'Y', 'y$', { desc = 'Yank to end of line' })

bind('i', 'jk', '<ESC>', { desc = 'Alternate escape' } )

-- Neovim terminal escape bind('', 'ping', '{', { remap = true })
  bind('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal Escape' })
  bind('t', 'jk', '<C-\\><C-n>', { desc = 'Terminal Escape' })
  bind('t', '<C-v><Esc>', '<Esc>', { desc = 'Terminal Escape' })
-- }

IsTransparent = false

function ToggleTransparent()
  if IsTransparent then
    vim.o.background = 'dark'
    IsTransparent = false
  else
    vim.cmd([[ hi Normal guibg=none ctermbg=none ]])
    IsTransparent = true
  end
end

bind('n', '<localleader>tr', ToggleTransparent, { desc = 'Toggle Transparency' })
