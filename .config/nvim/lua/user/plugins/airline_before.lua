-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

local set = vim.opt

-- Enable powerline symbols
vim.g.airline_powerline_fonts = 1

-- Enable/disable enhanced tabline. >
vim.g['airline#extensions#tabline#enabled'] = 1

-- Enable/disable displaying buffers with a single tab.
vim.g['airline#extensions#tabline#show_buffers'] = 1

-- Configure filename match rules to exclude from the tabline.
-- vim.g.airline#extensions#tabline#excludes = []

-- Configure how numbers are calculated in tab mode.
vim.g['airline#extensions#tabline#tab_nr_type'] = 0 -- # of splits (default)
-- vim.g['airline#extensions#tabline#tab_nr_type'] = 1 -- tab number

vim.g.airline_theme = 'base16'

if not vim.fn.exists('g:airline_powerline_fonts') then
  -- Use the default set of separators with a few customizations
  vim.g.airline_left_sep = '›'  -- Slightly fancier than '>'
  vim.g.airline_right_sep = '‹' -- Slightly fancier than '<'
end

-- Rainbow {
  vim.g.rainbow_active = 1
-- }

-- bookmarks {
  vim.g.bookmark_save_per_working_dir = 1
  vim.g.bookmark_auto_save_file = '$HOME/.local/share/nvim/bookmarks'
  vim.g.bookmark_auto_close = 1
-- }
