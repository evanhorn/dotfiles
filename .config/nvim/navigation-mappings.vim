" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

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

" Easier moving in tabs and windows {
" The lines conflict with the default digraph mapping of <C-K>
  map <C-J> <C-W>j<C-W>_
  map <C-K> <C-W>k<C-W>_
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_

  nnoremap <leader>w <C-W>w
  nnoremap <leader>W <C-W>W
" }

" Creates mappings for searching through quicklist {
  noremap [Q :cfirst<CR>
  noremap [q :cprev<CR>
  noremap ]q :cnext<CR>
  noremap ]Q :clast<CR>
" }

" Moving around faster {
  " nmap J 5j
  " nmap K 5k
  " vmap J 5j
  " vmap K 5k
  " nmap H ^
  " nmap L $
  " vmap H ^
  " vmap L $
" }

" Re-enabling keyword search in nvim {
  " nnoremap <Leader>k K
  " vnoremap <Leader>k K
" }

" Moving between buffers {
  " These ones would be even nicer but the integration
  " with tmux wouldn't work as well. I'd need to remember
  " two sets of mappings. Keeping them if I consider to
  " use neovim terminal instead of tmux
  " nmap gh <C-w>h
  " nmap gj <C-w>j
  " nmap gk <C-w>k
  " nmap gl <C-w>l
" }

" Moving to matching bracket {
  " nnoremap <tab> % 
  " vnoremap <tab> %
" }

" Split below by default
  set splitbelow
" Split right by default
  set splitright

" tab mappings {
  map <leader>tt :tabnew<cr>
  map <leader>te :tabedit
  map <leader>tc :tabclose<cr>
  map <leader>to :tabonly<cr>
  map <leader>tn :tabnext<cr>
  map <leader>tp :tabprevious<cr>
  map <leader>tf :tabfirst<cr>
  map <leader>tl :tablast<cr>
  map <leader>tm :tabmove

  " The following two lines conflict with moving to top and
  " bottom of the screen
  map <S-H> gT
  map <S-L> gt
" }
