-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

local Plug = vim.fn['plug#']
vim.call('plug#begin',  '$HOME/.local/share/nvim/plugged')

-- General {
  Plug 'junegunn/vim-plug'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'junegunn/vim-easy-align'
  if vim.fn.executable('ctags') then
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'liuchengxu/vista.vim'
  end
  Plug 'folke/todo-comments.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
-- }

-- Editor Configuration {
  Plug 'chrisbra/matchit'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'mbbill/undotree'
  Plug 'vim-scripts/restore_view.vim'
  Plug 'tpope/vim-abolish'
  Plug 'gcmt/wildfire.vim'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-unimpaired'
  Plug 'vim-scripts/file-line'
  Plug 'wesQ3/vim-windowswap'
  Plug 'troydm/zoomwintab.vim'
  Plug 'kshenoy/vim-signature'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'tpope/vim-obsession'
  Plug 'karb94/neoscroll.nvim'

  -- Colorschemes {
    Plug 'iCyMind/NeoSolarized'
    Plug 'joshdick/onedark.vim'
    Plug 'sickill/vim-monokai'
    Plug 'fenetikm/falcon'
  -- }

  -- Syntax {
    Plug 'kalafut/vim-taskjuggler'
  -- }

  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/nvim-treesitter-context'
  Plug 'p00f/nvim-ts-rainbow'

-- }

-- Langauge server {
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'

-- }

-- Files and fuzzy search {
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'tom-anders/telescope-vim-bookmarks.nvim'
-- }

-- Tmux Interface {
  Plug 'christoomey/vim-tmux-navigator'
-- }

-- General Programming {

  -- Testing {
    -- NOTE: read up on these packages --
    Plug 'tpope/vim-dispatch'
    Plug 'radenling/vim-dispatch-neovim'
    Plug 'janko-m/vim-test'
  -- }

  -- Version Control {
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'
    Plug 'rhysd/conflict-marker.vim'
  -- }

-- }

-- Snippets & AutoComplete {
  Plug('ms-jpq/coq_nvim', {branch = 'coq'})
  Plug('ms-jpq/coq.artifacts', {branch = 'artifacts'})
  Plug('ms-jpq/coq.thirdparty', {branch = '3p'})
-- }

-- HTML/CSS {
  Plug 'alvan/vim-closetag'
  Plug('rrethy/vim-hexokinase', {['do'] = 'make hexokinase'})
-- }

-- Misc {
  -- Plug('junegunn/fzf', {['do'] = { -> vim.fn['fzf#install']()}})
  Plug'junegunn/fzf'
  Plug 'chrisbra/csv.vim'
  Plug 'kevinoid/vim-jsonc'
  Plug('jalvesaq/Nvim-R', {branch = 'stable'})
-- }

-- LaTeX {
  Plug 'lervag/vimtex'
  Plug 'PatrBal/vim-textidote'
  Plug 'anufrievroman/vim-angry-reviewer'
-- }

-- Writing {
  Plug 'glidenote/memolist.vim'
  Plug 'jdelkins/vim-correction'
  Plug 'rhysd/vim-grammarous'
-- }

vim.call('plug#end')

require('user.plugins.config')

pcall(require, 'user.plugins.local.config')