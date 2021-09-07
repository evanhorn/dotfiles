" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker:

" Misc {
  let g:NERDShutUp=1

  if isdirectory(expand("$HOME/.config/nvim/pack/*/start/matchit.zip"))
    let b:match_ignorecase = 1
  endif
" }

" Editor Configuration {

 " editorconfig {
   let g:EditorConfig_exclude_patterns = ['fugitive://.*']
   " let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
 " }

 " indent-guides {
   let g:indent_guides_start_level = 2
   let g:indent_guides_guide_size = 1
   let g:indent_guides_enable_on_vim_startup = 0
 " }

 " vim-airline {
   " Set configuration options for the statusline plugin vim-airline.
   " Use the powerline theme and optionally enable powerline symbols.
   " To use the symbols , , , , , , and .in the statusline
   " segments add the following to your vimrc.before.local file:
   "   let g:airline_powerline_fonts=1
   " If the previous symbols do not render for you then install a
   " powerline enabled font.

   " See `:echo g:airline_theme_map` for some more choices
   " Default in terminal vim is 'dark'
   "
   " Enable powerline symbols
   let g:airline_powerline_fonts = 1

   " Enable/disable enhanced tabline. >
   let g:airline#extensions#tabline#enabled = 1

   " Enable/disable displaying buffers with a single tab.
   let g:airline#extensions#tabline#show_buffers = 1

   " Configure filename match rules to exclude from the tabline.
   " let g:airline#extensions#tabline#excludes = []

   " Configure how numbers are calculated in tab mode.
   let g:airline#extensions#tabline#tab_nr_type = 0 " # of splits (default)
   " let g:airline#extensions#tabline#tab_nr_type = 1 " tab number

   let g:airline_theme = 'solarized'

   if !exists('g:airline_powerline_fonts')
     " Use the default set of separators with a few customizations
     let g:airline_left_sep='›'  " Slightly fancier than '>'
     let g:airline_right_sep='‹' " Slightly fancier than '<'
   endif
 " }

 " Rainbow {
   if isdirectory(expand("$HOME/.config/nvim/pack/*/start/rainbow/"))
     let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
   endif
 " }

 " neosolarized {
   " Default value is "normal", Setting this option to "high" or "low" does use the
   " same Solarized palette but simply shifts some values up or down in order to
   " expand or compress the tonal range displayed.
   let g:neosolarized_contrast = "normal"

   " Special characters such as trailing whitespace, tabs, newlines, when displayed
   " using ":set list" can be set to one of three levels depending on your needs.
   " Default value is "normal". Provide "high" and "low" options.
   let g:neosolarized_visibility = "normal"

   " I make vertSplitBar a transparent background color. If you like the origin
   " solarized vertSplitBar style more, set this value to 0.
   let g:neosolarized_vertSplitBgTrans = 1

   " If you wish to enable/disable NeoSolarized from displaying bold, underlined
   " or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
   " Default values:
   let g:neosolarized_bold = 1
   let g:neosolarized_underline = 1
   let g:neosolarized_italic = 1

   " Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
   " text output by commands like `ls` aren't what you expect, you might want to
   " try disabling this option. Default value:
   let g:neosolarized_termBoldAsBright = 1
   color NeoSolarized             " Load a colorscheme
 " }

 " Solarized {
   set termguicolors
   let &t_8f = "[38;2;%lu;%lu;%lum"
   let &t_8b = "[48;2;%lu;%lu;%lum"
   color NeoSolarized             " Load a colorscheme
 " }

"" }

" Ctags {
  set tags=./tags;/,$HOME/.config/nvim/vimtags

  " Make tags placed in .git/tags file available in all levels of a repository
  let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
  if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
  endif
" }


" Editing Tools {

  " undotree {
    nnoremap <Leader>u :UndotreeToggle<CR>
    " If undotree is opened, it is likely one wants to interact with it.
    let g:undotree_SetFocusWhenToggle=1
  " }

  " tabular {

    " Tabular align {
    function! s:align()
      let p = '^\s*|\s.*\s|\s*$'
      if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      endif
    endfunction

    " Creates auto aligning tabular environment
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
    " }

    if exists(":Tabularize") || isdirectory(expand("$HOME/.config/nvim/pack/*/start/tabular/"))
      nmap <Leader>a& :Tabularize /&<CR>
      vmap <Leader>a& :Tabularize /&<CR>
      nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
      vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
      " nmap <Leader>a= :Tabularize /=<CR>
      " vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a=> :Tabularize /=><CR>
      vmap <Leader>a=> :Tabularize /=><CR>
      nmap <Leader>a: :Tabularize /:<CR>
      vmap <Leader>a: :Tabularize /:<CR>
      " nmap <Leader>a: :Tabularize /:\zs<CR>
      " vmap <Leader>a: :Tabularize /:\zs<CR>
      nmap <Leader>a:: :Tabularize /:\zs<CR>
      vmap <Leader>a:: :Tabularize /:\zs<CR>
      nmap <Leader>a, :Tabularize /,<CR>
      vmap <Leader>a, :Tabularize /,<CR>
      nmap <Leader>a,, :Tabularize /,\zs<CR>
      vmap <Leader>a,, :Tabularize /,\zs<CR>
      nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
      vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    endif
  " }

  " vim-multiple-cursors {
    " Disble deoplete when using multiple_cursors
    function g:Multiple_cursors_before()
      call deoplete#custom#buffer_option('auto_complete', v:false)
    endfunction
    function g:Multiple_cursors_after()
      call deoplete#custom#buffer_option('auto_complete', v:true)
    endfunction
  " }

" }

" ale {
  " For JavaScript files, use `eslint` (and only eslint)
  let g:ale_linters = {
  \   'javascript': ['eslint'],
  \ }

  " Mappings in the style of unimpaired-next
  nmap <silent> [W <Plug>(ale_first)
  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> ]W <Plug>(ale_last)

" }

" Session List {
  set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
  nmap <leader>sl :SessionList<CR>
  nmap <leader>ss :SessionSave<CR>
  nmap <leader>sc :SessionClose<CR>
" }

" JSON {
  nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
  let g:vim_json_syntax_conceal = 0
" }

" TagBar {
  if isdirectory(expand("$HOME/.config/nvim/pack/*/start/tagbar/"))
    nnoremap <silent> <leader>tb :TagbarToggle<CR>

    " Open Tagbar automatically on Vim startup
    " autocmd VimEnter * nested :TagbarOpen

    " Open Tagbar only if Vim started with supported file/files
    " autocmd VimEnter * nested :call tagbar#autoopen(1)

    " Open Tagbar when opening supported file
    autocmd FileType * nested :call tagbar#autoopen(0)

    " Open Tagbar in the current tab when switching to loaded supported buffer
    " autocmd BufEnter * nested :call tagbar#autoopen(0)

    " Open Tagbar only for specific filetypes
    " autocmd FileType c,cpp nested :TagbarOpen
  endif
" }

" Writing {

  " vimtex {
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_fold_enabled = 1

    " TOC settings
    let g:vimtex_toc_config = {
          \ 'name' : 'TOC',
          \ 'layers' : ['content', 'todo', 'include'],
          \ 'split_width' : 50,
          \ 'todo_sorted' : 0,
          \ 'show_help' : 1,
          \ 'show_numbers' : 1,
          \ 'mode' : 2,
          \}

    " }
" }

" Grepper {

" Search for the current word
  nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
  nmap gs <plug>(GrepperOperator)
  xmap gs <plug>(GrepperOperator)

  call SetupCommandAlias("ack", "GrepperAck")
  call SetupCommandAlias("grep", "GrepperGrep")
  call SetupCommandAlias("git", "GrepperGit")
  call SetupCommandAlias("rg", "GrepperRg")

" Open Grepper-prompt for a particular grep-alike tool
  nnoremap <Leader>g :Grepper -tool ack<CR>
  nnoremap <Leader>G :Grepper -tool git<CR>

" }

" Completion {

  " deoplete {
    " Use deoplete - set before initializing deoplete
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_complete = 1

    " show docstring in preview window
    let g:deoplete#sources#jedi#show_docstring = 1

    " Add deoplete before function calls
    packadd deoplete.nvim
    call deoplete#custom#source('ultisnips', 'rank', 1000)
    call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])

    " Add vimtex before using variable
    packadd vimtex
    call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete,
      \})

    call deoplete#custom#option('smart_case', v:true)

    " call deoplete#custom#option({
    "   \ 'auto_complete_delay': 200,
    "   \ 'smart_case': v:true,
    "   \ })

    inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

    " <CR>: close popup and save indent
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function() abort
      return deoplete#close_popup() . "\<CR>"
    endfunction

    " Undo completion
    inoremap <expr><C-g>     deoplete#undo_completion()
  " }

  " UltiSnips {
    " let g:UltiSnipsExpandTrigger="<tab>"
    " let g:UltiSnipsJumpForwardTrigger="<c-b>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-z>"

    " let g:UltiSnipsEditSplit = 'horizontal'
    " let g:ultisnips_python_quoting_style = 'double'
  " }

  " echodoc {
    set noshowmode
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'virtual'
  " }


" }

" Python {

  " Jedi-vim options {
    let g:jedi#completions_enabled = 0                  " Disable completions in lieu of deoplete-jedi
    " let g:jedi#completions_command = <C-Space>          " Start completion
    " let g:jedi#goto_assignments_command = <leader>g     " Go to definition
    " let g:jedi#goto_definitions_command = <leader>d     " Go to original definition
    " let g:jedi#documentation_command = <Leader>K        " Show pydoc documentation
    " let g:jedi#rename_command = <leader>r               " Rename variables
    " let g:jedi#usages_command = <leader>n               " Show usages of a name
    " let g:jedi#auto_initialization = 1                  " Automatic Initialization
    " let g:jedi#auto_vim_configuration = 1               " Set 'completeopt' and mappings
    let g:jedi#popup_on_dot = 0                         " Option to enable/disable autocompletion upon typing a period
    let g:jedi#popup_select_first = 0                   " Automatically select first entry that pops up
    " let g:jedi#auto_close_doc = 1                       " Automatically close docstring after completion
    " let g:jedi#show_call_signatures = 1                 " Display details of arguments of completed function
    let g:jedi#use_splits_not_buffers = "left"          " Use splits instead of buffers
    " let g:jedi#use_tabs_not_buffers = 1                 " Open new tab from 'go to', 'show definition', or 'related names'
    " let g:jedi#squelch_py_warning = 0                   " Suppress vim not loaded with +python
    " let g:jedi#completions_enable = 1                   " Enable/disable jedi completions
    " let g:jedi#use_splits_not_buffers = ''              " Use splits for 'go to', set to top, left, right, or bottom
  " }

  " python-mode {
    let g:pymode_rope = 0
    let g:pymode_folding=0
  " }

" }

" sessionman configuration {
  let g:sessionman_path = '$HOME/.config/nvim/sessions'
" }

" Matnicer configuration {
  au BufEnter *.m set conceallevel=2
  " au BufEnter *.m set concealcursor=
  " au BufEnter *.m set concealcursor=nc
   let g:matnicer_greek=1
" }

