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

vim.g.airline_theme = 'solarized'

if not vim.fn.exists('g:airline_powerline_fonts') then
  -- Use the default set of separators with a few customizations
  vim.g.airline_left_sep = '›'  -- Slightly fancier than '>'
  vim.g.airline_right_sep = '‹' -- Slightly fancier than '<'
end

-- Rainbow {
  vim.g.rainbow_active = 1
-- }

-- neosolarized {
  -- Default value is "normal", Setting this option to "high" or "low" does use the
  -- same Solarized palette but simply shifts some values up or down in order to
  -- expand or compress the tonal range displayed.
  vim.g.neosolarized_contrast = "normal"

  -- Special characters such as trailing whitespace, tabs, newlines, when displayed
  -- using ":set list" can be set to one of three levels depending on your needs.
  -- Default value is "normal". Provide "high" and "low" options.
  vim.g.neosolarized_visibility = "normal"

  -- I make vertSplitBar a transparent background color. If you like the origin
  -- solarized vertSplitBar style more, set this value to 0.
  vim.g.neosolarized_vertSplitBgTrans = 1

  -- If you wish to enable/disable NeoSolarized from displaying bold, underlined
  -- or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
  -- Default values:
  vim.g.neosolarized_bold = 1
  vim.g.neosolarized_underline = 1
  vim.g.neosolarized_italic = 1

  -- Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
  -- text output by commands like `ls` aren't what you expect, you might want to
  -- try disabling this option. Default value:
  vim.g.neosolarized_termBoldAsBright = 1

  vim.cmd [[color NeoSolarized]]
-- }

-- bookmarks {
  vim.g.bookmark_save_per_working_dir = 1
  vim.g.bookmark_auto_save_file = '$HOME/.local/share/nvim/bookmarks'
  vim.g.bookmark_auto_close = 1
-- }
