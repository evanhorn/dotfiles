" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

" Misc {
  let b:match_ignorecase = 1
  let test#strategy = "dispatch"
" }

" Editor Configuration {

  " editorconfig {
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
    let g:EditorConfig_max_line_indicator = 'line'
  " }

  " conflict marker {
    " disable the default highlight group
    let g:conflict_marker_highlight_group = ''

    " Include text after begin and end markers
    let g:conflict_marker_begin = '^<<<<<<< .*$'
    let g:conflict_marker_end   = '^>>>>>>> .*$'

    highlight ConflictMarkerBegin guibg=#2F7366
    highlight ConflictMarkerOurs guibg=#2E5049
    highlight ConflictMarkerTheirs guibg=#344F69
    highlight ConflictMarkerEnd guibg=#2F628E
    highlight ConflictMarkerCommonAncestorsHunk guibg=#754A81
  " }
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

 " Rainbow {
   let g:rainbow_active = 1
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

   set termguicolors
   color NeoSolarized             " Load a colorscheme
 " }

 " bookmarks {
   let g:bookmark_save_per_working_dir = 1
   let g:bookmark_auto_save_file = '$HOME/.local/share/nvim/bookmarks'
   let g:bookmark_auto_close = 1
 " }

"" }

" Ctags {
  set tags=./tags;/,$HOME/.local/share/nvim/vimtags

  " Make tags placed in .git/tags file available in all levels of a repository
  let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
  if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
  endif
" }

" Editing Tools {

  " undotree {
    nnoremap <leader>u <cmd>UndotreeToggle<CR>
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
      nmap <leader>a& <cmd>Tabularize /&<CR>
      vmap <leader>a& <cmd>Tabularize /&<CR>
      nmap <leader>a= <cmd>Tabularize /^[^=]*\zs=<CR>
      vmap <leader>a= <cmd>Tabularize /^[^=]*\zs=<CR>
      " nmap <leader>a= <cmd>Tabularize /=<CR>
      " vmap <leader>a= <cmd>Tabularize /=<CR>
      nmap <leader>a=> <cmd>Tabularize /=><CR>
      vmap <leader>a=> <cmd>Tabularize /=><CR>
      nmap <leader>a: <cmd>Tabularize /:<CR>
      vmap <leader>a: <cmd>Tabularize /:<CR>
      " nmap <leader>a: <cmd>Tabularize /:\zs<CR>
      " vmap <leader>a: <cmd>Tabularize /:\zs<CR>
      nmap <leader>a:: <cmd>Tabularize /:\zs<CR>
      vmap <leader>a:: <cmd>Tabularize /:\zs<CR>
      nmap <leader>a, <cmd>Tabularize /,<CR>
      vmap <leader>a, <cmd>Tabularize /,<CR>
      nmap <leader>a,, <cmd>Tabularize /,\zs<CR>
      vmap <leader>a,, <cmd>Tabularize /,\zs<CR>
      nmap <leader>a<Bar> <cmd>Tabularize /<Bar><CR>
      vmap <leader>a<Bar> <cmd>Tabularize /<Bar><CR>
    endif
  " }

  " vim-tmux {
  " Disable tmux navigator when zooming the Vim pane
  let g:tmux_navigator_disable_when_zoomed = 1
  " }

" }

" COQ {
  let g:coq_settings = { 'auto_start': v:true }
  " let g:coq_settings = { 'auto_start': 'shut-up }

  let g:coq_settings.keymap = {
        \'jump_to_mark': '<C-o>',
        \'eval_snips': '<leader>j',
        \}
" }

" " JSON {
"   nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc><cmd>set filetype=json<CR>
"   let g:vim_json_syntax_conceal = 0
" " }

" Vista {
  " How each level is indented and what to prepend.
  " This could make the display more compact or more spacious.
  " e.g., more compact: ["▸ ", ""]
  " Note: this option only works for the kind renderer, not the tree renderer.
  let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" }

" Writing {

  " tex-conceal {
    let g:tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
    let g:tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
    let g:tex_conceal = "abdmgs"
  " }

  " vimtex {
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_fold_enabled = 1
    let g:vimtex_quickfix_mode = 0
    let g:vimtex_grammar_textidote = {
          \ 'jar': '/opt/textidote/textidote.jar',
          \ }

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

  " memolist {
    nnoremap <localleader>mn  <cmd>MemoNew<CR>
    nnoremap <localleader>ml  <cmd>MemoList<CR>
    nnoremap <localleader>mg  <cmd>MemoGrep<CR>
  " }

" }

if filereadable(expand('$HOME/.config/nvim/plugin-config-after.lua'))
  source $HOME/.config/nvim/plugin-config-after.lua
endif
