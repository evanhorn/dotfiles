-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

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
