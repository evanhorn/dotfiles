-- treesitter {
require("nvim-treesitter.configs").setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
}
-- }

-- nvim lsp {
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {}

  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)


local nvim_lsp = require 'lspconfig'

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- Use <tab> to jump to next placeholder
  -- let g:coc_snippet_next = '<tab>'

  -- Use <C-j>, <C-k> to jump to next/previous placeholder
  -- buf_set_keymap('n', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Use <C-space>, <C-l> to trigger snippet expand; <C-j> to expand and jump
  -- buf_set_keymap('i', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Use <C-j> to select text for visual placeholder of snippet
  -- buf_set_keymap('v', '<C-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

  -- Use <C-space> to trigger completion.

  -- vim.api.nvim_command [[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
  -- vim.api.nvim_command [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]

end

-- local coq = require("coq")

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'bashls', 'clangd', 'cmake', 'cssls', 'dockerls',
                  'fortls', 'jedi_language_server', 'pylsp', 'pyright',
                  'r_language_server', 'texlab', 'vimls', 'yamlls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }

nvim_lsp.ltex.setup({
})

nvim_lsp.arduino_language_server.setup({
  cmd =  {
    -- Required
    "arduino-language-server",
    "-cli-config", "~/.arduino15/arduino-cli.yaml",
    -- Optional
    "-cli", "~/.local/bin/arduino-cli",
    "-clangd", "/usr/bin/clangd"
  }
})

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.html.setup{
  capabilities = capabilities,
  -- coq.lsp_ensure_capabilities()
}
nvim_lsp.jsonls.setup {
  capabilities = capabilities,
  -- coq.lsp_ensure_capabilities(
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
  -- )
}
end
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

