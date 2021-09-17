" vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

if filereadable(expand('$HOME/.config/nvim/plugin-config-after.lua'))
  source $HOME/.config/nvim/plugin-config-after.lua
endif

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

  " ALE Integration {

    " enable/disable ALE integration
    let g:airline#extensions#ale#enabled = 1

    " ALE error_symbol
    let airline#extensions#ale#error_symbol = 'E:'

    " ALE warning
    let airline#extensions#ale#warning_symbol = 'W:'

    " ALE show_line_numbers
    let airline#extensions#ale#show_line_numbers = 1

    " ALE open_lnum_symbol
    let airline#extensions#ale#open_lnum_symbol = '(L'

    " ALE close_lnum_symbol
    let airline#extensions#ale#close_lnum_symbol = ')'
  " }

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

" COC {

  " Prevent disappearing cursor
  let g:coc_disable_transparent_cursor = 1

  " Use <C-l> for trigger snippet expand.
  imap <C-l> <Plug>(coc-snippets-expand)

  " Use <C-j> for select text for visual placeholder of snippet.
  vmap <C-j> <Plug>(coc-snippets-select)

  " Use <C-j> for jump to next placeholder, it's default of coc.nvim
  let g:coc_snippet_next = '<c-j>'

  " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  let g:coc_snippet_prev = '<c-k>'

  " Use <C-j> for both expand and jump (make expand higher priority.)
  imap <C-j> <Plug>(coc-snippets-expand-jump)

  " Use <leader>x for convert visual selected code to snippet
  xmap <leader>x  <Plug>(coc-convert-snippet)

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ?
        \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use <tab> for jump to next placeholder
  let g:coc_snippet_next = '<tab>'

  " Make <CR> auto-select the first completion item and notify coc.nvim to
  " format on enter, <cr> could be remapped by other vim plugin
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
        \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K <cmd>call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json,python setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> for scroll float windows/popups.
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Show marketplace
  nnoremap <silent><nowait> <space>m  :<C-u>CocList marketplace<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }

" ale {
  let g:ale_disable_lsp = 1

  let g:ale_linters = {
  \   'python': ['jedils', 'flake8', 'mypy', 'pylint', 'pyright'],
  \   'sh': ['language_server'],
  \ }

  " Mappings in the style of unimpaired-next
  nmap <silent> [W <Plug>(ale_first)
  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> ]W <Plug>(ale_last)

  " let g:ale_completion_enabled = 1
" }

" JSON {
  nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc><cmd>set filetype=json<CR>
  let g:vim_json_syntax_conceal = 0
" }

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

" UltiSnips {
  let g:UltiSnipsExpandTrigger = '<tab>'
  let g:UltiSnipsJumpForwardTrigger = '<tab>'
  let g:UltiSnipsJumpBakwardTrigger = '<s-tab>'
" }
