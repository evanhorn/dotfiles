-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

local bind = vim.keymap.set
local remap = {remap = true}

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
