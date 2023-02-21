-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

-- First things first, can't stand default error signs (
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- )

-- Telescope (
local telescope = require("telescope")

-- Don't preview binaries (
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require("plenary.job"):new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end
-- )

-- local trouble = require("trouble.providers.telescope")

telescope.setup{
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with_filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim"
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    find_files = {
      mappings = {
        n = {
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            telescope.close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent lcd %s", dir))
          end
        }
      },
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  },
}

-- File Pickers(
vim.api.nvim_set_keymap("n", "<C-P>", "<CMD>lua require('telescope-config').project_files()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", "<CMD>lua require('telescope.builtin').file_browser()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>gr", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>fg", "<CMD>lua require('telescope.builtin').grep_string()<CR>", { noremap = true, silent = true })
-- )

-- VIM Pickers(
vim.api.nvim_set_keymap("n", "<localleader>bf", "<CMD>lua require('telescope.builtin').buffers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>hs", "<CMD>lua require('telescope.builtin').command_history()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>h", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>m", "<CMD>lua require('telescope.builtin').marks()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>qf", "<CMD>lua require('telescope.builtin').quickfix()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>j", "<CMD>lua require('telescope.builtin').jumplist()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>o", "<CMD>lua require('telescope.builtin').vim_options()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>r", "<CMD>lua require('telescope.builtin').registers()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "z=", "<CMD>lua require('telescope.builtin').spell_suggest()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>k", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { noremap = true, silent = true })
-- )

-- Neovim LSP Pickers (
vim.api.nvim_set_keymap("n", "<leader>ca", "<CMD>lua require('telescope.builtin').lsp_code_actions()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>sd", "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>sw", "<CMD>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", { noremap = true, silent = true })
-- )

-- Git Pickers (
vim.api.nvim_set_keymap("n", "<localleader>ci", "<CMD>lua require('telescope.builtin').git_commits()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>bci", "<CMD>lua require('telescope.builtin').git_bcommits()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>br", "<CMD>lua require('telescope.builtin').git_branches()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>gs", "<CMD>lua require('telescope.builtin').git_status()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>st", "<CMD>lua require('telescope.builtin').git_stash()<CR>", { noremap = true, silent = true })
-- )

-- Extensions (
telescope.load_extension("vim_bookmarks")

vim.api.nvim_set_keymap("n", "ma", "<CMD>lua require('telescope').extensions.vim_bookmarks.all()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<localleader>bm", "<CMD>lua require('telescope').extensions.vim_bookmarks.current_file()<CR>", { noremap = true, silent = true })
-- )

-- )

-- Trouble (
require("trouble").setup{}

vim.api.nvim_set_keymap("n", "<localleader>xx", "<CMD>Trouble<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>xw", "<CMD>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>xd", "<CMD>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>xl", "<CMD>Trouble loclist<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<localleader>xq", "<CMD>Trouble quickfix<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "gR", "<CMD>Trouble lsp_references<CR>", { silent = true, noremap = true })
-- )

-- todo-comments (
require("todo-comments").setup{
  colors = {
    error = { "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "#10B981" },
    default = { "#7C3AED" },
  },
}

vim.api.nvim_set_keymap("n", "<localleader>td", "<CMD>TodoTrouble<CR>", { noremap = true, silent = true })
-- )
