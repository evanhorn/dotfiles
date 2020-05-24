" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

set background=dark         " Assume a dark background

let mapleader = ','
let maplocalleader = '_'

filetype plugin indent on   " Automatically detect file types.

syntax on                   " Syntax highlighting
set autoindent                  " Indent at the same level of the previous line

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
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
  set ruler                   " Show the ruler
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
  set tabstop=4                   " An indentation every four columns
  set shiftwidth=4                " Use indents of 4 spaces
  set softtabstop=4               " Let backspace delete indent
  set expandtab                   " Tabs are spaces, not tabs
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
  " set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" }

" Setting up the directories {
  set backup                  " Backups are nice ...
  set backupdir=$HOME/.config/nvim/backup/
  set viewdir=$HOME/.config/nvim/views/
  set directory=$HOME/.config/nvim/swap/
  if has('persistent_undo')
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
    set undofile
    if !has('nvim')
      set undodir=$HOME/.config/nvim/undo/
    endif
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

set linespace=0                 " No extra spaces between rows
set showmatch                   " Show matching brackets/parenthesis
set winminheight=0              " Windows can be 0 line high

set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
set spell                           " Spell checking on
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" Statusline {
  if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif
" }

" Add exclusions to mkview and loadview
" eg: *.*, svn-commit.tmp
let g:skipview_files = [
    \ '\[example pattern\]'
    \ ]

scriptencoding utf-8

" For JavaScript files, use `eslint` (and only eslint)
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }

" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)
