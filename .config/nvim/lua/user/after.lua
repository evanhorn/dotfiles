-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

-- treesitter {
require("nvim-treesitter.configs").setup{
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "sh", "bash", "latex" },
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true, disable = { "" }, },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        --   -- f keymaps are for key-values
        --   ["af"] = "@function.outer",
        --   ["if"] = "@function.inner",
        --   -- c keymaps are for dictionaries
        --   ["ac"] = "@class.outer",
        --   ["ic"] = "@class.inner",
        --   -- k keymaps are for comments
        --   ["ak"] = "@comment.outer",
        --   ["ik"] = "@comment.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      -- Granular control over motions on key-values and dictionaries
      -- if you want it
    },
    swap = {
      enable = true,
      -- Swap parameters; ie. if a key-value has multiple values and you want to swap them
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      -- Press v. inside a key-value or a comment (then . or ; repeatedly)
      ['.'] = 'textsubjects-smart',
      -- Press v; to select surrounding dictionary
      [';'] = 'textsubjects-container-outer',
    }
  },
}

-- Context display for long dictionaries and key-value entries (
require("treesitter-context").setup{
  throttle = true,
  patterns = {
    -- This will show context for functions, classes and mehod
    -- in all languages
    default = { 'function', 'class', 'method' },
    -- In OpenFOAM files, we have dicts and key-val pairs
    -- (you might want to add '^list')
    foam = { '^dict$', '^key_value$' }
  },
  -- Make sure foam is treated with exact Lua patterns
  exact_patterns = { foam = true, }
}
-- )
-- }

-- lsp {

require("mason").setup{
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

local servers = {
  arduino_language_server = {
    cmd = {
      -- Required
      "arduino-language-server",
      "-cli-config", "~/.arduino15/arduino-cli.yaml",

      -- Optional
      "-cli", "~/.local/bin/arduino-cli",
      "-clangd", "/usr/bin/clangd"
    },
  },
  bashls = {},
  clangd = {},
  cmake = {},
  cssls = {},
  dockerls = {},
  fortls = {},
  html = {},
  jsonls = {},
  jedi_language_server = {},
  pyright = {},
  pylsp = {
    pylsp = {
      configurationSources = { "flake8", "mypy" },
      plugins = {
        flake8 = { enabled = true },
        pylsp_mypy = { enabled = true, live_mode = true },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        mccabe = { enabled = false },
      },
    },
  },
  lua_ls = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    },
  },
  ltex = {},
  taplo = {},
  texlab = {},
  vimls = {},
  yamlls = {},
}

require("mason-lspconfig").setup{
  ensure_installed = servers,
  automatic_installation = true,
}

local bind = vim.keymap.set
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = {silent = true, buffer=bufnr}
  bind('n', 'gD', vim.lsp.buf.declaration, bufopts)
  bind('n', 'gd', vim.lsp.buf.definition, bufopts)
  bind('n', 'K', vim.lsp.buf.hover, bufopts)
  bind('n', 'gi', vim.lsp.buf.implementation, bufopts)
  bind('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  bind('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  bind('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  bind('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  bind('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  bind('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  bind('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  bind('n', 'gr', vim.lsp.buf.references, bufopts)
  bind('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end


local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

local lspconfig = require('lspconfig')
local coq = require('coq')
for server, settings in pairs(servers) do
  lspconfig[server].setup{coq.lsp_ensure_capabilities{
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  },
  settings = settings,
}
end

require("coq_3p") {
  { src = "repl", max_lines = 99, deadline = 500, unsafe = { "sudo", "rm", "poweroff", "mv", "shutdown", "reboot" }, },
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "figlet", short_name = "BIG" },
  { src = "vimtex", short_name = "vTEX" },
}
-- }

-- telescope & trouble {

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

local bind = vim.keymap.set
-- File Pickers(
bind("n", "-", telescope.extensions.file_browser.file_browser, silent)
bind("n", "<localleader>ff", builtin.find_files, silent)
bind("n", "<localleader>fg", builtin.live_grep, silent)
bind("n", "<localleader>fb", builtin.buffers, silent)
bind("n", "<localleader>gr", builtin.grep_string, silent)
-- )

-- VIM Pickers(
bind("n", "<localleader>fb", builtin.buffers, silent)
bind("n", "<localleader>hs", builtin.command_history, silent)
bind("n", "<localleader>h", builtin.help_tags, silent)
bind("n", "<localleader>m", builtin.marks, silent)
bind("n", "<localleader>qf", builtin.quickfix, silent)
bind("n", "<localleader>j", builtin.jumplist, silent)
bind("n", "<localleader>o", builtin.vim_options, silent)
bind("n", "<localleader>r", builtin.registers, silent)
bind("n", "z=", builtin.spell_suggest, silent)
bind("n", "<localleader>k", builtin.keymaps, silent)
-- )

-- Neovim LSP Pickers (
bind("n", "<localleader>sd", builtin.lsp_document_symbols, silent)
bind("n", "<localleader>sw", builtin.lsp_dynamic_workspace_symbols, silent)
-- )

-- Git Pickers (
bind("n", "<localleader>ci", builtin.git_commits, silent)
bind("n", "<localleader>bci", builtin.git_bcommits, silent)
bind("n", "<localleader>br", builtin.git_branches, silent)
bind("n", "<localleader>gs", builtin.git_status, silent)
bind("n", "<localleader>st", builtin.git_stash, silent)
-- )

-- Extensions (
telescope.load_extension("vim_bookmarks")

bind("n", "ma", telescope.extensions.vim_bookmarks.all, silent)
bind("n", "<localleader>bm", telescope.extensions.vim_bookmarks.current_file, silent)
-- )

-- )

-- Trouble (
require("trouble").setup{}

bind("n", "<localleader>xx", "<cmd>Trouble<cr>", silent)
bind("n", "<localleader>xw", "<cmd>Trouble workspace_diagnostics<cr>", silent)
bind("n", "<localleader>xd", "<cmd>Trouble document_diagnostics<cr>", silent)
bind("n", "<localleader>xl", "<cmd>Trouble loclist<cr>", silent)
bind("n", "<localleader>xq", "<cmd>Trouble quickfix<cr>", silent)
bind("n", "gR", "<cmd>Trouble lsp_references<cr>", silent)
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

bind("n", "<localleader>td", "<cmd>TodoTrouble<cr>", silent)
-- )
-- }
