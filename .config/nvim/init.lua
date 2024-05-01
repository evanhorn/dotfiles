-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

require('user.settings')
require('user.mappings')

pcall(require, 'custom.before')
require('user.before')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
-- General {
  'machakann/vim-sandwich',
  'tpope/vim-repeat',
  'tpope/vim-commentary',
  'junegunn/vim-easy-align',
  'ludovicchabant/vim-gutentags',
  'liuchengxu/vista.vim',
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
-- }

-- Editor Configuration {
  'chrisbra/matchit',
  'editorconfig/editorconfig-vim',
  {
    'vim-airline/vim-airline',
    dependencies = { 'vim-airline/vim-airline-themes' },
  },
  'mbbill/undotree',
  'vim-scripts/restore_view.vim',
  'gcmt/wildfire.vim',
  'troydm/zoomwintab.vim',
  'MattesGroeger/vim-bookmarks',
  'tpope/vim-unimpaired',
  'tpope/vim-obsession',

  -- Colorschemes {
    'rrethy/nvim-base16',
  -- }

  -- Syntax {
    'kalafut/vim-taskjuggler',
  -- }

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
  },

-- }

-- Language server {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {
        'williamboman/mason.nvim',
        config = function()
          require("mason").setup{
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          }
        end,
      },
      'williamboman/mason-lspconfig.nvim',
      }
    },
-- }

-- Debug Adapter {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      {
        'folke/neodev.nvim',
        config = function()
          require("neodev").setup{
            library = {
              plugins = { "nvim-dap-ui" },
              types = true,
            }
          }
        end,
      },
    },
    config = function()
      require("dapui").setup()
    end,
  },
  'jbyuki/one-small-step-for-vimkind',
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require("dap-python").setup()
      require("dap-python").test_runner = 'pytest'
    end,
  },
-- }

-- Files and fuzzy search {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'tom-anders/telescope-vim-bookmarks.nvim',
    },
  },
-- }

-- Tmux Interface {
  'christoomey/vim-tmux-navigator',
-- }

-- General Programming {

  -- Testing {
    -- NOTE: read up on these packages --
    'radenling/vim-dispatch-neovim',
    'vim-test/vim-test',
  -- }

  -- Version Control {
    'tpope/vim-fugitive',
    'mhinz/vim-signify',
    'rhysd/conflict-marker.vim',
  -- }

-- }

-- Snippets & AutoComplete {
  {
    'ms-jpq/coq_nvim',
    branch = 'coq',
    build = ':COQdeps',
    lazy = false,
    dependencies = {
      {'ms-jpq/coq.artifacts', branch='artifacts'},
      {'ms-jpq/coq.thirdparty', branch='3p'},
    },
  },
-- }

-- HTML/CSS {
  'alvan/vim-closetag',
  {
    'rrethy/vim-hexokinase',
    build = 'make hexokinase',
  },
-- }

-- Misc {
  {
    'junegunn/fzf',
    build = ':call fzf#install()',
  },
  'chrisbra/csv.vim',
  'kevinoid/vim-jsonc',
  {
    'jalvesaq/Nvim-R',
    branch = 'stable',
  },
-- }

-- LaTeX {
  {
    'lervag/vimtex',
    lazy = false,
  },
  'PatrBal/vim-textidote',
  'anufrievroman/vim-angry-reviewer',
-- }

-- Writing {
  'jdelkins/vim-correction',
  'rhysd/vim-grammarous',
-- }

{ import = 'user.plugins' },
{ import = 'custom.plugins' }
}, {})

require('user.after')
pcall(require, 'custom.after')

vim.cmd [[
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
]]
