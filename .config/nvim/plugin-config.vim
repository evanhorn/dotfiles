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

  " airline {
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

  " rainbow {
      let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
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

" }

" OmniComplete {
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

  " tabularize {

    if exists(":Tabularize")
      nmap <Leader>a& :Tabularize /&<CR>
      vmap <Leader>a& :Tabularize /&<CR>
      nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
      vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
      nmap <Leader>a=> :Tabularize /=><CR>
      vmap <Leader>a=> :Tabularize /=><CR>
      nmap <Leader>a: :Tabularize /:<CR>
      vmap <Leader>a: :Tabularize /:<CR>
      nmap <Leader>a:: :Tabularize /:\zs<CR>
      vmap <Leader>a:: :Tabularize /:\zs<CR>
      nmap <Leader>a, :Tabularize /,<CR>
      vmap <Leader>a, :Tabularize /,<CR>
      nmap <Leader>a,, :Tabularize /,\zs<CR>
      vmap <Leader>a,, :Tabularize /,\zs<CR>
      nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
      vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    endif

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

" ctrlp {
  let g:ctrlp_working_path_mode = 'ra'
  nnoremap <silent> <D-t> :CtrlP<CR>
  nnoremap <silent> <D-r> :CtrlPMRU<CR>
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

  if executable('ag')
    let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
  elseif executable('ack-grep')
    let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
  elseif executable('ack')
    let s:ctrlp_fallback = 'ack %s --nocolor -f'
  " On Windows use "dir" as fallback command.
  elseif WINDOWS()
    let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
  else
    let s:ctrlp_fallback = 'find %s -type f'
  endif
  if exists("g:ctrlp_user_command")
    unlet g:ctrlp_user_command
  endif
  let g:ctrlp_user_command = {
    \ 'types': {
      \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
      \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': s:ctrlp_fallback
  \ }

  let g:ctrlp_extensions = ['funky']
  nnoremap <Leader>fu :CtrlPFunky<Cr>
" }

" TagBar {
  if isdirectory(expand("$HOME/.config/nvim/pack/*/start/tagbar/"))
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
  endif
" }

" Rainbow {
  if isdirectory(expand("$HOME/.config/nvim/pack/*/start/rainbow/"))
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
  endif
" }

  " deoplete {
    " Use deoplete
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#auto_complete = 1

    " show docstring in preview window
    let g:deoplete#sources#jedi#show_docstring = 1

    " Use smartcase
    " call deoplete#custom#option('smart_case', v:true)

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

  " echodoc {
    set noshowmode
    let g:echodoc#enable_at_startup = 1
    let g:echodoc#type = 'virtual'
  " }

  " jedi-vim {
  " }

" Solarized {
  " let g:solarized_termcolors=256
  " let g:solarized_termtrans=1
  " let g:solarized_contrast="normal"
  " let g:solarized_visibility="normal"
  set termguicolors
  let &t_8f = "[38;2;%lu;%lu;%lum"
  let &t_8b = "[48;2;%lu;%lu;%lum"
  " color solarized8            " Load a colorscheme
  " color solarized             " Load a colorscheme
  color NeoSolarized             " Load a colorscheme
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

" Python {

  " " pymode {
  "   " Disable if python support not present
  "   if !has('python') && !has('python3')
  "     let g:pymode = 0
  "   endif

  "   let g:pymode_lint_checkers = ['pyflakes']
  "   let g:pymode_trim_whitespaces = 0
  "   let g:pymode_options = 0
  "   let g:pymode_rope = 0
  "   let g:pymode_run_bind = '<Leader>R'                                 " Key for run python code
  "   let g:pymode_lint = 0                                               " Turns off pylint script
  "   let g:pymode_lint_jump = 0                                          " Auto jump to first error
  "   let g:pymode_lint_hold = 0                                          " Hold cursor in current window
  "   let g:pymode_lint_minheight = 3                                     " Minimal height of pylint error window
  "   let g:pymode_lint_maxheight = 6                                     " Maximal height of pylint error window
  "   let g:pymode_folding = 0                                            " Turns on/off python folding
  " " }

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

" Writing {

  " vimtex {
    let g:vimtex_view_method = 'zathura'
    let g:tex_flavor = 'latex'
    " TOC settings
    let g:vimtex_toc_config = {
          \ 'name' : 'TOC',
          \ 'layers' : ['content', 'todo', 'include'],
          \ 'resize' : 1,
          \ 'split_width' : 50,
          \ 'todo_sorted' : 0,
          \ 'show_help' : 1,
          \ 'show_numbers' : 1,
          \ 'mode' : 2,
          \}

  let g:pymode_lint_checkers = ['pyflakes']
  let g:pymode_trim_whitespaces = 0
  let g:pymode_options = 0
  let g:pymode_rope = 0
  let g:pymode_run_bind = '<Leader>R'                                 " Key for run python code
  let g:pymode_lint = 0                                               " Turns off pylint script
  let g:pymode_lint_jump = 0                                          " Auto jump to first error
  let g:pymode_lint_hold = 0                                          " Hold cursor in current window
  let g:pymode_lint_minheight = 3                                     " Minimal height of pylint error window
  let g:pymode_lint_maxheight = 6                                     " Maximal height of pylint error window
  let g:pymode_folding = 0                                            " Turns on/off python folding
" }

" Syntastic options {
  let g:syntastic_aggregate_errors=1
  " let g:syntastic_always_populate_loc_list=1
  " let g:syntastic_auto_loc_list=1
  " let g:syntastic_auto_jump=1
  let g:syntastic_python_checkers=['pylama']
  let g:syntastic_error_symbol='✗'
  let g:syntastic_style_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
  let g:syntastic_style_warning_symbol='⚠'
" }

" Jedi-vim options {
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
  " let g:jedi#use_tabs_not_buffers = 1                 " Open new tab from 'go to', 'show definition', or 'related names'
  " let g:jedi#squelch_py_warning = 0                   " Suppress vim not loaded with +python
  " let g:jedi#completions_enable = 1                   " Enable/disable jedi completions
  " let g:jedi#use_splits_not_buffers = ''              " Use splits for 'go to', set to top, left, right, or bottom
" }

" sessionman configuration {
  let g:sessionman_path = '$HOME/.config/nvim/sessions'
" }

" UltiSnips configuration {
  " let g:UltiSnipsDir = '"$HOME/.config/nvim/pack/minpac/vim-snippets/UltiSnips"'
  " let g:UltiSnipsSnippetsDir = '"$HOME/.config/nvim/pack/minpac/vim-snippets/UltiSnips"'
  " let g:UltiSnipsEditSplit = 'vertical'
  let g:UltiSnipsEditSplit = 'horizontal'
  let g:ultisnips_python_quoting_style = 'double'
" }

" latex-suite configuration {
  " autocmd BufNewFile,BufRead *.tex
  " imap <C-Space> <Plug>IMAP_JumpForward
  " nmap <C-Space> <Plug>IMAP_JumpForward
  " vmap <C-Space> <Plug>IMAP_JumpForward
  " let g:tex_fold_enabled=1
  let g:tex_flavor='latex'
  let g:Tex_DefaultTargetFormat='pdf'
  let g:Tex_CompileRule_dvi='latex -synctex=1 -src-specials -interaction=nonstopmode $*'
  " let g:Tex_CompileRule_ps='ps2pdf $*'
  let g:Tex_CompileRule_pdf='pdflatex -synctex=1 -src-specials -interaction=nonstopmode $*'
  let g:Tex_ViewRule_dvi='okular'
  let g:Tex_ViewRule_ps='okular'
  let g:Tex_ViewRule_pdf='okular'
  let g:Tex_MultipleCompileFormats='dvi,pdf'
  " let g:Tex_FoldedSections = 'part,chapter,section,subsection,subsubsection,paragraph'
  let g:Tex_FoldedEnvironments = 'verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage,frame,columns,itemize,displaymath'
  " let g:Tex_FoldedEnvironments = 'verbatim,comment,eq,gather,align,figure,table,thebibliography,keywords,abstract,titlepage'
  " let g:Tex_FoldedEnvironments = ',frame,columns,itemize,displaymath'
  " let g:Tex_FoldedMisc = 'item,slide,preamble,<<<'
  let g:Tex_FoldedMisc = 'preamble,<<<,comments'
  let g:Tex_GotoError = 0

  " function! SyncTexForward()
  "   let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), " :r" )." .pdf"
  "   let execstr = " silent !okular --unique " .s:syncfile." \\#src:.line(" ." ).expand(" %\:p" ).' &'
  "   exec execstr
  " endfunction
  " nnoremap <leader>f :call SyncTexForward()<CR>
" }

" Matnicer configuration {
  au BufEnter *.m set conceallevel=2
  " au BufEnter *.m set concealcursor=
  " au BufEnter *.m set concealcursor=nc
   let g:matnicer_greek=1
" }

