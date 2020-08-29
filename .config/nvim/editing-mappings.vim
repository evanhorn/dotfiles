" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Code folding options {
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>
" }

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" The default mappings for editing and applying the configuration
" are <leader>ev and <leader>sv respectively.
noremap <leader>ev :call <SID>EditVIMRC()<CR>
noremap <leader>sv :source $HOME/.config/nvim/init.vim<CR>

" Easier formatting
nnoremap <silent> <leader>q gwip

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Shortcuts {
  " Change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv
" }

" Some helpers to edit mode {
  " Practical VIM and http://vimcasts.org/episodes/the-edit-command/
  cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
  map <leader>ew :e %%
  map <leader>es :sp %%
  map <leader>ev :vsp %%
  map <leader>et :tabe %%
" }

" Most prefer to toggle search highlighting rather than clear the current
" search results.
nmap <silent> <leader>/ :set invhlsearch<CR>

"OmniComplete {
    if has("autocmd") && exists("+omnifunc")
      autocmd Filetype *
        \ if &omnifunc == "" |
        \   setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
    endif

    hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
    hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
    hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

    " Some convenient mappings
    "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
    inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
    inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
    inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
    inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

    " Automatically open and close the popup menu / preview window
    au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
    set completeopt=menu,preview,longest
  " }

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>
