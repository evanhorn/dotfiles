" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

if filereadable(expand('$HOME/.config/nvim/plugin-config-before.vim'))
  source $HOME/.config/nvim/plugin-config-before.vim
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '$HOME/.local/share/nvim/plugged')

" General {
  Plug 'junegunn/vim-plug'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
" }

" Editor Configuration {
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
  Plug 'luochen1990/rainbow'
  Plug 'wesQ3/vim-windowswap'
  Plug 'troydm/zoomwintab.vim'
  Plug 'kshenoy/vim-signature'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'tyru/open-browser.vim'
  Plug 'tpope/vim-obsession'

  " Colorschemes {
    Plug 'iCyMind/NeoSolarized'
    Plug 'joshdick/onedark.vim'
    Plug 'sickill/vim-monokai'
    Plug 'fenetikm/falcon'
  " }

  " Syntax {
    Plug 'kalafut/vim-taskjuggler'
    Plug 'evanhorn/vim-openfoam'
  " }

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

" }

" Langauge server {
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

  " " COQ {
  "   " main one
  "   Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  "   " 9000+ Snippets
  "   Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

  "   " lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
  "   " Need to **configure separately**

  "   Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
  "   " - shell repl
  "   " - nvim lua api
  "   " - scientific calculator
  "   " - comment banner
  "   " - etc
  " " }

  " " CMP {
  "   Plug 'hrsh7th/cmp-nvim-lsp'
  "   Plug 'hrsh7th/cmp-buffer'
  "   Plug 'hrsh7th/cmp-path'
  "   Plug 'hrsh7th/cmp-cmdline'
  "   Plug 'hrsh7th/nvim-cmp'

  "   " For vsnip users.
  "   Plug 'hrsh7th/cmp-vsnip'
  "   Plug 'hrsh7th/vim-vsnip'

  "   " For luasnip users.
  "   " Plug 'L3MON4D3/LuaSnip'
  "   " Plug 'saadparwaiz1/cmp_luasnip'

  "   " For ultisnips users.
  "   " Plug 'SirVer/ultisnips'
  "   " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

  "   " For snippy users.
  "   " Plug 'dcampos/nvim-snippy'
  "   " Plug 'dcampos/cmp-snippy'
  " " }

  " " LSPSAGA {
  "   Plug 'glepnir/lspsaga.nvim'
  " " }

" }

" Files and fuzzy search {
  " Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  " Telescope Extensions {
    Plug 'fhill2/telescope-ultisnips.nvim'
    Plug 'fannheyward/telescope-coc.nvim'
    Plug 'tom-anders/telescope-vim-bookmarks.nvim'
    Plug 'dhruvmanila/telescope-bookmarks.nvim'
    Plug 'nvim-telescope/telescope-project.nvim'
  " }
" }

" Tmux Interface {
  Plug 'christoomey/vim-tmux-navigator'
" }

" General Programming {
  Plug 'tpope/vim-commentary'
  Plug 'godlygeek/tabular'
  if executable('ctags')
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'liuchengxu/vista.vim'
  endif
  Plug 'folke/todo-comments.nvim'
  Plug 'folke/trouble.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

  Plug 'dense-analysis/ale'

  " Testing {
    " NOTE: read up on these packages "
    Plug 'tpope/vim-dispatch'
    Plug 'radenling/vim-dispatch-neovim'
    Plug 'janko-m/vim-test'
  " }

  " Version Control {
    Plug 'tpope/vim-fugitive'
    Plug 'mhinz/vim-signify'
    Plug 'rhysd/conflict-marker.vim'
  " }

" }

" Snippets & AutoComplete {
  Plug 'honza/vim-snippets'
  Plug 'wellle/tmux-complete.vim'
  Plug 'SirVer/ultisnips'
" }

" HTML/CSS {
  Plug 'alvan/vim-closetag'
  Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" }

" Misc {
  Plug 'chrisbra/csv.vim'
  Plug 'kevinoid/vim-jsonc'
  Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
" }

" LaTeX {
  Plug 'lervag/vimtex'
" }

" Writing {
  Plug 'glidenote/memolist.vim'
  Plug 'jdelkins/vim-correction'
  Plug 'rhysd/vim-grammarous'
" }

call plug#end()

if filereadable(expand('$HOME/.config/nvim/plugin-config-after.vim'))
  source $HOME/.config/nvim/plugin-config-after.vim
endif
