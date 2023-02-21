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

local builtin = require('telescope.builtin')
local silent = {silent = true}

-- File Pickers(
vim.keymap.set("n", "-", telescope.extensions.file_browser.file_browser, silent)
vim.keymap.set("n", "<localleader>ff", builtin.find_files, silent)
vim.keymap.set("n", "<localleader>fg", builtin.live_grep, silent)
vim.keymap.set("n", "<localleader>fb", builtin.buffers, silent)
vim.keymap.set("n", "<localleader>gr", builtin.grep_string, silent)
-- )

-- VIM Pickers(
vim.keymap.set("n", "<localleader>fb", builtin.buffers, silent)
vim.keymap.set("n", "<localleader>hs", builtin.command_history, silent)
vim.keymap.set("n", "<localleader>h", builtin.help_tags, silent)
vim.keymap.set("n", "<localleader>m", builtin.marks, silent)
vim.keymap.set("n", "<localleader>qf", builtin.quickfix, silent)
vim.keymap.set("n", "<localleader>j", builtin.jumplist, silent)
vim.keymap.set("n", "<localleader>o", builtin.vim_options, silent)
vim.keymap.set("n", "<localleader>r", builtin.registers, silent)
vim.keymap.set("n", "z=", builtin.spell_suggest, silent)
vim.keymap.set("n", "<localleader>k", builtin.keymaps, silent)
-- )

-- Neovim LSP Pickers (
vim.keymap.set("n", "<localleader>sd", builtin.lsp_document_symbols, silent)
vim.keymap.set("n", "<localleader>sw", builtin.lsp_dynamic_workspace_symbols, silent)
-- )

-- Git Pickers (
vim.keymap.set("n", "<localleader>ci", builtin.git_commits, silent)
vim.keymap.set("n", "<localleader>bci", builtin.git_bcommits, silent)
vim.keymap.set("n", "<localleader>br", builtin.git_branches, silent)
vim.keymap.set("n", "<localleader>gs", builtin.git_status, silent)
vim.keymap.set("n", "<localleader>st", builtin.git_stash, silent)
-- )

-- Extensions (
telescope.load_extension("vim_bookmarks")

vim.keymap.set("n", "ma", telescope.extensions.vim_bookmarks.all, silent)
vim.keymap.set("n", "<localleader>bm", telescope.extensions.vim_bookmarks.current_file, silent)
-- )

-- )

-- Trouble (
require("trouble").setup{}

vim.keymap.set("n", "<localleader>xx", "<cmd>Trouble<cr>", silent)
vim.keymap.set("n", "<localleader>xw", "<cmd>Trouble workspace_diagnostics<cr>", silent)
vim.keymap.set("n", "<localleader>xd", "<cmd>Trouble document_diagnostics<cr>", silent)
vim.keymap.set("n", "<localleader>xl", "<cmd>Trouble loclist<cr>", silent)
vim.keymap.set("n", "<localleader>xq", "<cmd>Trouble quickfix<cr>", silent)
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references<cr>", silent)
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

vim.keymap.set("n", "<localleader>td", "<cmd>TodoTrouble<cr>", silent)
-- )
