-- treesitter {
require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "sh", "bash"},
  },
}
-- }

-- nvim lsp {

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  "arduino_language_server",
  "bashls",
  "clangd",
  "cmake",
  "cssls",
  "dockerls",
  "fortls",
  "jedi_language_server",
  "ltex",
  "pylsp",
  "pyright",
  "r_language_server",
  "sumneko_lua",
  "texlab",
  "vimls",
  "yamlls"
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings(
{
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}
)

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

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
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gy", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "rn", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)

  -- buf_set_keymap("n", "<C-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<CMD>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>f", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)

end

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lsp_installer.on_server_ready(function(server)
  local default_opts = {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }

  local server_opts = {
    ["arduino_language_server"] = function()
      default_opts.settings = {
        cmd =  {
          -- Required
          "arduino-language-server",
          "-cli-config", "~/.arduino15/arduino-cli.yaml",

          -- Optional
          "-cli", "~/.local/bin/arduino-cli",
          "-clangd", "/usr/bin/clangd"
        }
      }
    end,
    ["cssls"] = function()
      default_opts.settings = {
        capabilities = capabilities,
      }
    end,
    ["html"] = function()
      default_opts.settings = {
        capabilities = capabilities,
      }
    end,
    ["jsonls"] =  function()
      default_opts.settings = {
        capabilities = capabilities,
      }
    end,
    ["sumneko_lua"] =  function()
      default_opts.settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    end,
  }

  -- Use the server's custom settings, if they exist, otherwise default to the default options
  local server_options = server_opts[server.name] and server_opts[server.name]() or default_opts
  server:setup(server_options)
end)
-- }

-- Telescope {
local telescope = require("telescope")

-- Don't preview binaries{
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

telescope.setup {
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

-- File Pickers{
vim.api.nvim_set_keymap("n", "<C-P>", "<CMD>lua require('telescope-config').project_files()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "-", "<CMD>lua require('telescope.builtin').file_browser()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>gr", "<CMD>lua require('telescope.builtin').live_grep()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>fg", "<CMD>lua require('telescope.builtin').grep_string()<CR>", {noremap = true, silent = true})
-- }

-- VIM Pickers{
vim.api.nvim_set_keymap("n", "<localleader>bf", "<CMD>lua require('telescope.builtin').buffers()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>hs", "<CMD>lua require('telescope.builtin').command_history()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>h", "<CMD>lua require('telescope.builtin').help_tags()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>m", "<CMD>lua require('telescope.builtin').marks()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>qf", "<CMD>lua require('telescope.builtin').quickfix()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>j", "<CMD>lua require('telescope.builtin').jumplist()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>o", "<CMD>lua require('telescope.builtin').vim_options()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>r", "<CMD>lua require('telescope.builtin').registers()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "z=", "<CMD>lua require('telescope.builtin').spell_suggest()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>k", "<CMD>lua require('telescope.builtin').keymaps()<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<localleader>fh", "<CMD>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<localleader>fh", "<CMD>lua require('telescope.builtin').current_buffer_tags()<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<localleader>nc", "<CMD>lua require('telescope-config').nvim_config()<CR>", {noremap = true, silent = true})
-- }

-- Neovim LSP Pickers {
vim.api.nvim_set_keymap("n", "<leader>ca", "<CMD>lua require('telescope.builtin').lsp_code_actions()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>sd", "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>sw", "<CMD>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<localleader>fh", "<CMD>lua require('telescope.builtin').diagnostics({["bufnr"]=0})<CR>", {noremap = true, silent = true})
--vim.api.nvim_set_keymap("n", "<localleader>fh", "<CMD>lua require('telescope.builtin').diagnostics()<CR>", {noremap = true, silent = true}) vim.api.nvim_set_keymap("n", "<localleader>fh", "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>", {noremap = true, silent = true})
-- }

-- Git Pickers {
vim.api.nvim_set_keymap("n", "<localleader>ci", "<CMD>lua require('telescope.builtin').git_commits()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>bci", "<CMD>lua require('telescope.builtin').git_bcommits()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>br", "<CMD>lua require('telescope.builtin').git_branches()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>gs", "<CMD>lua require('telescope.builtin').git_status()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>st", "<CMD>lua require('telescope.builtin').git_stash()<CR>", {noremap = true, silent = true})
-- }

-- Extensions {
telescope.load_extension("vim_bookmarks")

vim.api.nvim_set_keymap("n", "ma", "<CMD>lua require('telescope').extensions.vim_bookmarks.all()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<localleader>bm", "<CMD>lua require('telescope').extensions.vim_bookmarks.current_file()<CR>", {noremap = true, silent = true})
-- }

-- Trouble {
require("trouble").setup {}

vim.api.nvim_set_keymap("n", "<localleader>xx", "<CMD>Trouble<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xw", "<CMD>Trouble workspace_diagnostics<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xd", "<CMD>Trouble document_diagnostics<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xl", "<CMD>Trouble loclist<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<localleader>xq", "<CMD>Trouble quickfix<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "gR", "<CMD>Trouble lsp_references<CR>", {silent = true, noremap = true})
-- }

-- todo-comments {
require("todo-comments").setup {
  colors = {
    error = { "#DC2626" },
    warning = { "#FBBF24" },
    info = { "#2563EB" },
    hint = { "#10B981" },
    default = { "#7C3AED" },
  },
}

vim.api.nvim_set_keymap("n", "<localleader>td", "<CMD>TodoTrouble<CR>", {noremap = true, silent = true})
-- }

require("coq_3p") {
  {
    src = "repl",
    max_lines = 99,
    deadline = 500,
    unsafe = { "sudo", "rm", "poweroff", "mv", "shutdown", "reboot" },
  },
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "figlet", short_name = "BIG" },
  { src = "vimtex", short_name = "vTEX" },
}

-- }
