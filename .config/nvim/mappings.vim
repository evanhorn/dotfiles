" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Wrapped lines {
  " Make sure that movements work as expected in wrapped lines
  noremap <silent> j gj
  noremap <silent> k gk
  noremap <silent> 0 g0
  noremap <silent> ^ g^
  noremap <silent> $ g$

  noremap <silent> gj j
  noremap <silent> gk k
  noremap <silent> g0 0
  noremap <silent> g^ ^
  noremap <silent> g$ $
" }

" Creates mappings for searching through quicklist {
  noremap [Q <cmd>cfirst<CR>
  noremap [q <cmd>cprev<CR>
  noremap ]q <cmd>cnext<CR>
  noremap ]Q <cmd>clast<CR>
" }

" Split below by default
  set splitbelow
" Split right by default
  set splitright

" Easier horizontal scrolling
map zl zL
map zh zH

" tab mappings {
  map <leader>tt <cmd>tabnew<cr>
  map <leader>te :tabedit
  map <leader>tc <cmd>tabclose<cr>
  map <leader>to <cmd>tabonly<cr>
  map <leader>tn <cmd>tabnext<cr>
  map <leader>tp <cmd>tabprevious<cr>
  map <leader>tf <cmd>tabfirst<cr>
  map <leader>tl <cmd>tablast<cr>
  map <leader>tm :tabmove
" }

" Code folding options {
  nmap <leader>f0 <cmd>set foldlevel=0<CR>
  nmap <leader>f1 <cmd>set foldlevel=1<CR>
  nmap <leader>f2 <cmd>set foldlevel=2<CR>
  nmap <leader>f3 <cmd>set foldlevel=3<CR>
  nmap <leader>f4 <cmd>set foldlevel=4<CR>
  nmap <leader>f5 <cmd>set foldlevel=5<CR>
  nmap <leader>f6 <cmd>set foldlevel=6<CR>
  nmap <leader>f7 <cmd>set foldlevel=7<CR>
  nmap <leader>f8 <cmd>set foldlevel=8<CR>
  nmap <leader>f9 <cmd>set foldlevel=9<CR>
" }

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . <cmd>normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Easier formatting
nnoremap <silent> <leader>q gwip

" Adjust viewports to the same size
map <leader>= <C-w>=

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
nmap <silent> <leader>/ <cmd>set invhlsearch<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

inoremap jk <ESC>

" Neovim terminal escape mapping {
  if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap jk <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>

    highlight! link TermCursor Cursor
    highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15

    if executable('nvr')
      let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
    endif
  endif
" }

