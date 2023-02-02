-- treesitter (
require("nvim-treesitter.configs").setup{
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "sh", "bash" },
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
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}
-- )

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

-- First things first, can't stand default error signs (
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- )

-- nvim lsp (
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
  sumneko_lua = {
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

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gs", "<CMD>lua vim.lsp.buf.signature.help()<CR>", opts)
  buf_set_keymap("n", "gy", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)

  buf_set_keymap("n", "<localleader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<localleader>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<localleader>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<localleader>wl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<localleader>e", "<CMD>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "[d", "<CMD>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<CMD>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<localleader>q", "<CMD>lua vim.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<localleader>f", "<CMD>lua vim.lsp.buf.format()<CR>", opts)

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

require("coq_3p") {
  { src = "repl", max_lines = 99, deadline = 500, unsafe = { "sudo", "rm", "poweroff", "mv", "shutdown", "reboot" }, },
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "figlet", short_name = "BIG" },
  { src = "vimtex", short_name = "vTEX" },
}
