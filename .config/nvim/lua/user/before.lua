-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local bind = vim.keymap.set
local set = vim.opt
local remap = {remap = true}

vim.g.coq_settings = {
  auto_start = true,
  keymap  = {
    jump_to_mark = '<C-o>',
    eval_snips = '<leader>j',
  },
}

-- writing {

-- tex-conceal {
  vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
  vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
  vim.g.tex_conceal = "abdmgs"
-- }

-- vimtex {
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_fold_enabled = 1
  vim.g.vimtex_quickfix_mode = 0
  vim.g.vimtex_doc_enabled = 1
  vim.g.vimtex_doc_handlers = {'vimtex#doc#handlers#texdoc'}
  vim.g.vimtex_doc_confirm_single = false
  vim.g.vimtex_grammar_textidote = {
        jar = '/opt/textidote/textidote.jar',
        }

  -- TOC settings
  vim.g.vimtex_toc_config = {
        name = 'TOC',
        layers = {'content', 'todo', 'include'},
        split_width = 50,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
        mode = 2,
        }
-- }

-- vim-textidote {
vim.g.textidote_jar = '/opt/textidote/textidote.jar'
-- }

-- vim-angry-reviewer {
bind('n', '<localleader>ar', ':AngryReviewer<cr>')
vim.g.AngryReviewerEnglish = 'american'
-- }
-- }

-- editor {

  -- editorconfig {
    vim.g.EditorConfig_exclude_patterns = {'fugitive://.*', 'scp://.*'}
    vim.g.EditorConfig_max_line_indicator = 'line'
  -- }

  -- conflict marker {
    -- disable the default highlight group
    vim.g.conflict_marker_highlight_group = ''

    -- Include text after begin and end markers
    vim.g.conflict_marker_begin = '^<<<<<<< .*$'
    vim.g.conflict_marker_end   = '^>>>>>>> .*$'

    vim.cmd [[highlight ConflictMarkerBegin guibg = #2F7366]]
    vim.cmd [[highlight ConflictMarkerOurs guibg = #2E5049]]
    vim.cmd [[highlight ConflictMarkerTheirs guibg = #344F69]]
    vim.cmd [[highlight ConflictMarkerEnd guibg = #2F628E]]
    vim.cmd [[highlight ConflictMarkerCommonAncestorsHunk guibg = #754A81]]
  -- }

-- Editing Tools {

  -- undotree {
    bind('n', '<leader>u', '<cmd>UndotreeToggle<CR>')
    -- If undotree is opened, it is likely one wants to interact with it.
    vim.g.undotree_SetFocusWhenToggle = 1
  -- }

  -- vim-easy-align {
    bind({'x', 'n'}, 'ga', '<Plug>(EasyAlign)', remap)
  -- }

  -- vim-tmux {
  -- Disable tmux navigator when zooming the Vim pane
  vim.g.tmux_navigator_disable_when_zoomed = 1
  -- }

-- }

-- Vista {
  -- How each level is indented and what to prepend.
  -- This could make the display more compact or more spacious.
  -- e.g., more compact: ["▸ ", ""]
  -- Note: this option only works for the kind renderer, not the tree renderer.
  vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
-- }
-- }

-- airline {

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
-- }

-- ctags {

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
-- }
