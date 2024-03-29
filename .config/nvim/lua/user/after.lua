-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local bind = vim.keymap.set

-- Treesitter {
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
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ak"] = "@comment.outer",
          ["ik"] = "@comment.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
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

-- Context display for long dictionaries and key-value entries {
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
-- }

-- }

-- DAP {
local dap = require('dap')
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = 'server', host = config.host or "127.0.0.1", port = config.port or 8086 })
end

-- Color DAP signs {
local DapBreakpoint = 'DiagnosticSignError'
local DapLogPoint = 'DiagnosticSignHint'
local DapStopped = 'DiagnosticSignOK'

-- local
vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = DapBreakpoint, numhl = DapBreakpoint })
vim.fn.sign_define('DapBreakpointCondition', { text = 'ﳁ ', texthl = DapBreakpoint, numhl = DapBreakpoint })
vim.fn.sign_define('DapBreakpointRejected', { text = ' ', texthl = DapBreakpoint, numhl = DapBreakpoint })
vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = DapLogPoint, numhl = DapLogPoint })
vim.fn.sign_define('DapStopped', { text = ' ', texthl = DapStopped, numhl = DapStopped })
-- }

-- DAP keymaps {
bind('n', '<space>b', dap.toggle_breakpoint, { noremap = true, desc = "DAP: Toggle Breakpoint" })
bind('n', '<space>c', dap.continue, { noremap = true, desc = "DAP: Continue" })
bind('n', '<space>o', dap.step_over, { noremap = true, desc = "DAP: Step Over" })
bind('n', '<space>i', dap.step_into, { noremap = true, desc = "DAP: Step Into" })
bind('n', '<space>s', dap.step_into, { noremap = true, desc = "DAP: Step Into" })
-- bind('n', '<F12>', dap.ui.widgets.hover, { noremap = true, desc = "DAP: Hover" })
-- bind('n', '<F5>', require"osv".launch({port = 8086}), { noremap = true, desc = "DAP: Run" })
bind('n', '<F12>', [[:lua require"dap.ui.widgets".hover()<CR>]], { noremap = true, desc = "DAP: Hover"  })
bind('n', '<F5>', [[:lua require"osv".launch({port = 8086})<CR>]], { noremap = true, desc = "DAP: Run"  })

bind('n', '<leader>dn', require('dap-python').test_method, { noremap = true, desc = "DAP Python: Test Method"  })
bind('n', '<leader>df', require('dap-python').test_class, { noremap = true, desc = "DAP Python: Test Class"  })
bind('n', '<leader>ds', require('dap-python').debug_selection, { noremap = true, desc = "DAP Python: Debug Selection"  })
-- }

-- DAP UI {
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"]=function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"]=function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"]=function()
  dapui.close()
end
-- }

-- }

-- LSP {

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
  pylsp = {
    pylsp = {
      configurationSources = { "flake8", "mypy" },
      plugins = {
        flake8 = { enabled = true },
        pylsp_mypy = { enabled = true, live_mode = true },
      },
    },
  },
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
    },
  },
  ltex = {},
  taplo = {},
  texlab = {},
  vimls = {},
  yamlls = {},
}

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup{
  ensure_installed = servers,
  automatic_installation = true,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local builtin = require('telescope.builtin')

local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('<space>rn', vim.lsp.buf.rename, '[R]e[N]ame')
  nmap('<space>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', builtin.lsp_references, '[G]oto [R]eference')
  nmap('gI', builtin.lsp_implementations,  '[G]oto [I]mplementation')
  nmap('<space>D', vim.lsp.buf.type_definition, '[T]ype [D]efinition')
  nmap("<localleader>ds", builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap("<localleader>ws", builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<space>K', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration,  '[G]oto [D]eclaration')
  nmap('<space>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<space>wr', vim.lsp.buf.remove_workspace_folder,  '[W]orkspace [R]emove Folder')
  nmap('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


local lspconfig = require('lspconfig')
local coq = require('coq')
for server, settings in pairs(servers) do
  lspconfig[server].setup{
  on_attach = on_attach,
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

-- Telescope & Trouble {

-- First things first, can't stand default error signs {
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }

-- Telescope {
local telescope = require("telescope")

-- Don't preview binaries {
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
-- }

-- local trouble = require("trouble.providers.telescope")

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
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
            vim.cmd(string.format("{ silent = true } lcd %s", dir))
          end
        }
      },
      find_command = { "fd", "--type", "f", "--strip-cwd-prefix" }
    },
  },
}

bind("n", "-", telescope.extensions.file_browser.file_browser, { silent = true })
bind('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })
bind('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
bind('n', '<leader>h', builtin.help_tags, { desc = '[S]earch [H]elp' })
bind('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
bind('n', '<leader>g', builtin.live_grep, { desc = '[S]earch by [G]rep' })
bind('n', '<leader>d', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
bind('n', '<leader>r', builtin.resume, { desc = '[S]earch [R]resume' })

bind("n", "<localleader>b", builtin.buffers, { desc = '[S]earch [B]uffers' })
bind("n", "<localleader>h", builtin.command_history, { desc = '[S]earch [H]istory' })
bind("n", "<localleader>m", builtin.marks, { desc = '[S]earch [M]arks' })
bind("n", "<localleader>q", builtin.quickfix, { desc = 'Search [Q]uick [F]ix' })
bind("n", "<localleader>j", builtin.jumplist, { desc = '[J]umplist' })
bind("n", "<localleader>o", builtin.vim_options, { desc = 'vim[O]ptions' })
bind("n", "<localleader>r", builtin.registers, { desc = '[S]earch [R]egisters' })
bind("n", "z=", builtin.spell_suggest, { desc = 'Spelling Suggestions' })
bind("n", "<localleader>k", builtin.keymaps, { desc = 'Search [K]ey[M]aps' })

-- -- Git Pickers {
-- bind("n", "<localleader>ci", builtin.git_commits, { silent = true })
-- bind("n", "<localleader>bci", builtin.git_bcommits, { silent = true })
-- bind("n", "<localleader>br", builtin.git_branches, { silent = true })
-- bind("n", "<localleader>gs", builtin.git_status, { silent = true })
-- bind("n", "<localleader>st", builtin.git_stash, { silent = true })
-- -- }

-- Extensions {
telescope.load_extension("vim_bookmarks")

bind("n", "ma", telescope.extensions.vim_bookmarks.all, { desc = 'Book[M][A]rks' })
bind("n", "<localleader>bm", telescope.extensions.vim_bookmarks.current_file, { desc = 'Current File [B]ook[M]arks' })
-- }

-- }

-- Trouble {
require("trouble").setup{}

bind("n", "<localleader>xx", "<cmd>Trouble<cr>", { desc = 'Trouble Diagnostics' })
bind("n", "<localleader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = 'Trouble Workspace Diagnostics' })
bind("n", "<localleader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = 'Trouble Document Diagnostics' })
bind("n", "<localleader>xl", "<cmd>Trouble loclist<cr>", { desc = 'Trouble Location List' })
bind("n", "<localleader>xq", "<cmd>Trouble quickfix<cr>", { desc = 'Trouble Quick Fix' })
bind("n", "gR", "<cmd>Trouble lsp_references<cr>", { desc = 'Trouble LSP References' })
-- }

-- todo-comments {
require("todo-comments").setup{
  colors = {
    error = { "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "#10B981" },
    default = { "#7C3AED" },
  },
}

bind("n", "<localleader>td", "<cmd>TodoTrouble<cr>", { silent = true })
-- }
-- }
