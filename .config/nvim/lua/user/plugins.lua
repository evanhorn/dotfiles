-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

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
  'folke/todo-comments.nvim',
  'folke/trouble.nvim',
  'kyazdani42/nvim-web-devicons',
-- }

-- Editor Configuration {
  'chrisbra/matchit',
  'editorconfig/editorconfig-vim',
  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  'mbbill/undotree',
  'vim-scripts/restore_view.vim',
  'tpope/vim-abolish',
  'gcmt/wildfire.vim',
  'tpope/vim-speeddating',
  'tpope/vim-unimpaired',
  'vim-scripts/file-line',
  'wesQ3/vim-windowswap',
  'troydm/zoomwintab.vim',
  'kshenoy/vim-signature',
  'MattesGroeger/vim-bookmarks',
  'tpope/vim-obsession',
  'karb94/neoscroll.nvim',

  -- Colorschemes {
    'iCyMind/NeoSolarized',
    'joshdick/onedark.vim',
    'sickill/vim-monokai',
    'fenetikm/falcon',
  -- }

  -- Syntax {
    'kalafut/vim-taskjuggler',
  -- }

  {'nvim-treesitter/nvim-treesitter', build=':TSUpdate'},
  'nvim-treesitter/nvim-treesitter-textobjects',
  'nvim-treesitter/nvim-treesitter-context',
  'p00f/nvim-ts-rainbow',

-- }

-- Langauge server {
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

-- }

-- Files and fuzzy search {
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',
  'tom-anders/telescope-vim-bookmarks.nvim',
-- }

-- Tmux Interface {
  'christoomey/vim-tmux-navigator',
-- }

-- General Programming {

  -- Testing {
    -- NOTE: read up on these packages --
    'tpope/vim-dispatch',
    'radenling/vim-dispatch-neovim',
    'janko-m/vim-test',
  -- }

  -- Version Control {
    'tpope/vim-fugitive',
    'mhinz/vim-signify',
    'rhysd/conflict-marker.vim',
  -- }

-- }

-- Snippets & AutoComplete {
  {'ms-jpq/coq_nvim', branch='coq', build=':COQdeps'},
  {'ms-jpq/coq.artifacts', branch='artifacts'},
  {'ms-jpq/coq.thirdparty', branch='3p'},
-- }

-- HTML/CSS {
  'alvan/vim-closetag',
  {'rrethy/vim-hexokinase', build='make hexokinase'},
-- }

-- Misc {
  {'junegunn/fzf', build=':call fzf#install()'},
  'chrisbra/csv.vim',
  'kevinoid/vim-jsonc',
  {'jalvesaq/Nvim-R', branch = 'stable'},
-- }

-- LaTeX {
  {'lervag/vimtex', lazy=false},
  'PatrBal/vim-textidote',
  'anufrievroman/vim-angry-reviewer',
-- }

-- Writing {
  'glidenote/memolist.vim',
  'jdelkins/vim-correction',
  'rhysd/vim-grammarous',
-- }
})

require('user.plugins.config')

pcall(require, 'user.plugins.local.config')
