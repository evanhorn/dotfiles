-- treesitter {
require("nvim-treesitter.configs").setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
}
-- }

-- telescope {
local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    bookmarks = {
      selected_browser = 'firefox',
      url_open_plugin = 'open_browser',
      firefox_profile_name = 'wklfjx5g.default',
    }
  }
}

telescope.load_extension('ultisnips')
telescope.load_extension('coc')
telescope.load_extension('vim_bookmarks')
telescope.load_extension('project')
telescope.load_extension('bookmarks')

  -- File Pickers{
  vim.api.nvim_set_keymap('n', '<C-P>', '<CMD>lua require(\'telescope-config\').project_files()<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '-', '<CMD>lua require(\'telescope.builtin\').file_browser()<CR>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>gr', '<CMD>lua require(\'telescope.builtin\').live_grep()<CR>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fg', '<CMD>lua require(\'telescope.builtin\').grep_string()<CR>', {noremap = true, silent = true})
  -- }

  -- VIM Pickers{
  vim.api.nvim_set_keymap('n', '<localleader>buf', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>hist', '<cmd>lua require(\'telescope.builtin\').command_history()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>h', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>m', '<cmd>lua require(\'telescope.builtin\').marks()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>qf', '<cmd>lua require(\'telescope.builtin\').quickfix()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>jmp', '<cmd>lua require(\'telescope.builtin\').jumplist()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>opt', '<cmd>lua require(\'telescope.builtin\').vim_options()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>reg', '<cmd>lua require(\'telescope.builtin\').registers()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', 'z=', '<cmd>lua require(\'telescope.builtin\').spell_suggest()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>km', '<cmd>lua require(\'telescope.builtin\').keymaps()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').current_buffer_fuzzy_find()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').current_buffer_tags()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>nc', '<CMD>lua require(\'telescope-config\').nvim_config()<CR>', {noremap = true, silent = true})
  -- }

  -- Neovim LSP Pickers {
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_workspace_symbols()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_code_actions()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_document_diagnostics()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_workspace_diagnostics()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_implementations()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_definitions()<cr>', {noremap = true, silent = true})
  --vim.api.nvim_set_keymap('n', '<localleader>fh', '<cmd>lua require(\'telescope.builtin\').lsp_type_definitions()<cr>', {noremap = true, silent = true})
  -- }

  -- Git Pickers {
  vim.api.nvim_set_keymap('n', '<localleader>ci', '<cmd>lua require(\'telescope.builtin\').git_commits()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>bci', '<cmd>lua require(\'telescope.builtin\').git_bcommits()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>br', '<cmd>lua require(\'telescope.builtin\').git_branches()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>gs', '<cmd>lua require(\'telescope.builtin\').git_status()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>st', '<cmd>lua require(\'telescope.builtin\').git_stash()<cr>', {noremap = true, silent = true})
  -- }

  -- Extensions {
  vim.api.nvim_set_keymap('n', '<localleader>p', '<cmd>lua require(\'telescope\').extensions.project.project{}<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>sn', '<cmd>lua require(\'telescope\').extensions.ultisnips.ultisnips{}<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', 'ma', '<cmd>lua require(\'telescope\').extensions.vim_bookmarks.all()<cr>', {noremap = true, silent = true})
  vim.api.nvim_set_keymap('n', '<localleader>bm', '<cmd>lua require(\'telescope\').extensions.vim_bookmarks.current_file()<cr>', {noremap = true, silent = true})
  -- }
-- }

-- Trouble {
require("trouble").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

vim.api.nvim_set_keymap("n", "<localleader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})
-- }

-- -- todo-comments {
require("todo-comments").setup {
  colors = {
    error = { "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "#10B981" },
    default = { "#7C3AED" },
  },
}

vim.api.nvim_set_keymap('n', '<localleader>td', '<CMD>TodoTrouble<CR>', {noremap = true, silent = true})
-- }

