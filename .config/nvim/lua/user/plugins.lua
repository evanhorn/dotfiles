-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

pcall(require, 'user.plugins.local.before')

require('user.plugins.before')

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
  {'folke/todo-comments.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
  {'folke/trouble.nvim', dependencies = 'nvim-tree/nvim-web-devicons'},
-- }

-- Editor Configuration {
  'chrisbra/matchit',
  'editorconfig/editorconfig-vim',
  {'vim-airline/vim-airline-themes', dependencies = {'vim-airline/vim-airline'}},
  'mbbill/undotree',
  'vim-scripts/restore_view.vim',
  'gcmt/wildfire.vim',
  'troydm/zoomwintab.vim',
  'MattesGroeger/vim-bookmarks',
  'tpope/vim-obsession',

  -- Colorschemes {
    'iCyMind/NeoSolarized',
  -- }

  -- Syntax {
    'kalafut/vim-taskjuggler',
  -- }

  {'nvim-treesitter/nvim-treesitter', build=':TSUpdate'},
  {'nvim-treesitter/nvim-treesitter-textobjects', dependencies = {'nvim-treesitter/nvim-treesitter'}},
  {'nvim-treesitter/nvim-treesitter-context', dependencies = {'nvim-treesitter/nvim-treesitter'}},

-- }

-- Langauge server {
  {'williamboman/mason-lspconfig.nvim',
      dependencies = {'williamboman/mason.nvim', 'neovim/nvim-lspconfig'}},
-- }

-- Files and fuzzy search {
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {'nvim-lua/plenary.nvim'}},
  {'nvim-telescope/telescope-file-browser.nvim',
      dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}},
  {'tom-anders/telescope-vim-bookmarks.nvim',
      dependencies = {'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim'}},
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
  {'ms-jpq/coq_nvim', branch='coq', build=':COQdeps'},
  {'ms-jpq/coq.artifacts', branch='artifacts', dependencies = {'ms-jpq/coq_nvim'}},
  {'ms-jpq/coq.thirdparty', branch='3p', dependencies = {'ms-jpq/coq_nvim'}},
-- }

-- HTML/CSS {
  'alvan/vim-closetag',
  {'rrethy/vim-hexokinase', build='make hexokinase'},
-- }

-- Misc {
  {'junegunn/fzf', build=':call fzf#install()'},
  'chrisbra/csv.vim',
  'kevinoid/vim-jsonc',
  {'jalvesaq/Nvim-R', branch='stable'},
-- }

-- LaTeX {
  {'lervag/vimtex', lazy=false},
  'PatrBal/vim-textidote',
  'anufrievroman/vim-angry-reviewer',
-- }

-- Writing {
  'jdelkins/vim-correction',
  'rhysd/vim-grammarous',
-- }
})

require('user.plugins.after')

pcall(require, 'user.plugins.local.after')
