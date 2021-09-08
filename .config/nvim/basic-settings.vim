" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

scriptencoding utf-8

set background=dark         " Assume a dark background

let mapleader = ','
let maplocalleader = ';'

filetype plugin indent on   " Automatically detect file types.

syntax on                   " Syntax highlighting
set autoindent              " Indent at the same level of the previous line

set cmdheight=2             " Give more space for displaying messages.

" Having longer update time (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

if has('clipboard')
  if has('unnamedplus')     " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
  else                      " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
  endif
endif

set modeline
set showcmd                 " Show partial commands in status line and
set showmode                " Display the current mode
set backspace=indent,eol,start  " Backspace for dummies
set hidden                  " Allow buffer switching without saving
set wildmenu                " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" Search {
  set ignorecase                  " Case insensitive search
  set smartcase                   " Case sensitive when uc present
  set number                      " Line numbers on
  set ruler                       " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set path+=app/**                " Add all subdirectories to search
" }

" Formatting {
  set nowrap                      " Do not wrap long lines
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set scrolloff=3                 " Minimum lines to keep above and below cursor
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
"}

" Global tabs/spaces {
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }

" Setting up the directories {
  set backup                  " Backups are nice ...
  set backupdir=$HOME/.local/share/nvim/backup/
  if has('persistent_undo')
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undofile
    augroup vimrc
      autocmd!
      autocmd BufWritePre /tmp/* setlocal noundofile
    augroup END
  endif
" }

set foldenable                  " Auto fold code
set mouse=a                     " Automatically enable mouse usage
set mousehide                   " Hide the mouse cursor while typing

set tabpagemax=15               " Only show 15 tabs

set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
" highlight clear CursorLineNr    " Remove highlight color from current line number
"
set termguicolors

set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high

set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set shortmess+=filmnrxoOtTc         " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

set conceallevel=2

let g:tex_flavor = 'latex'

