" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

set background=dark         " Assume a dark background

let mapleader = ','
let maplocalleader = ';'

filetype plugin indent on   " Automatically detect file types.

set cmdheight=2             " Give more space for displaying messages.

" Having longer update time (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=number

set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

set pastetoggle=<F12>

set cursorline                  " Highlight current line
set termguicolors

set showmatch                   " Show matching brackets/parenthesis

" set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set whichwrap=b,s,h,l           " Backspace and cursor keys wrap too

set shortmess+=mrc              " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore         " Allow for cursor beyond last character

set conceallevel=2

" Cliboard settings {
if has('clipboard')
  if has('unnamedplus')     " When possible use + register for copy-paste
      set clipboard=unnamed,unnamedplus
  else                      " On mac and Windows, use * register for copy-paste
      set clipboard=unnamed
  endif
endif
" }

" Search {
  set ignorecase                  " Case insensitive search
  set smartcase                   " Case sensitive when uc present
  set number                      " Line numbers on
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  " set path+=app/**                " Add all subdirectories to search
" }

" Formatting {
  set nowrap                      " Do not wrap long lines
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set scrolloff=3                 " Minimum lines to keep above and below cursor
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
"}

" Backup and undo files {
  set backup                  " Backups are nice ...
  set backupdir=$HOME/.local/state/nvim/backup/
  if has('persistent_undo')
    set undofile
  endif
" }
