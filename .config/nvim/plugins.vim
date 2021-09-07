" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

" General {
  call minpac#add('mhinz/vim-grepper')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('jiangmiao/auto-pairs')
  call minpac#add('terryma/vim-multiple-cursors', {'type': 'opt'})
  call minpac#add('vim-scripts/sessionman.vim')
  call minpac#add('tpope/vim-obsession')
  call minpac#add('tpope/vim-scriptease', {'type': 'opt'})
" }

" Editor Configuration {
  call minpac#add('chrisbra/matchit')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('vim-airline/vim-airline')
  call minpac#add('vim-airline/vim-airline-themes')
  call minpac#add('bling/vim-bufferline')
  call minpac#add('easymotion/vim-easymotion')
  call minpac#add('mbbill/undotree')
  call minpac#add('nathanaelkane/vim-indent-guides')
  call minpac#add('vim-scripts/restore_view.vim')
  call minpac#add('tpope/vim-abolish')
  call minpac#add('osyo-manga/vim-over')
  call minpac#add('gcmt/wildfire.vim')
  call minpac#add('tpope/vim-speeddating')
  call minpac#add('tpope/vim-unimpaired')
  call minpac#add('vim-scripts/file-line')
  call minpac#add('luochen1990/rainbow')
  call minpac#add('wesQ3/vim-windowswap')
  call minpac#add('troydm/zoomwintab.vim')
  call minpac#add('kshenoy/vim-signature')
  call minpac#add('ncm2/float-preview.nvim', {'type': 'opt'})


  " Colorschemes {
    call minpac#add('iCyMind/NeoSolarized')
    call minpac#add('joshdick/onedark.vim' , { 'branch': 'main', 'type': 'opt'})
    call minpac#add('mhartington/oceanic-next' , {'type': 'opt'})
    call minpac#add('sickill/vim-monokai' , {'type': 'opt'})
    call minpac#add('fenetikm/falcon' , {'type': 'opt'})
  " }

  " Syntax {
    call minpac#add('hail2u/vim-css3-syntax')
    call minpac#add('kalafut/vim-taskjuggler')
    call minpac#add('capitancambio/vim-matnicer', {'type': 'opt'})
    call minpac#add('sudar/vim-arduino-syntax', {'type': 'opt'})
    call minpac#add('evanhorn/vim-openfoam', {'type': 'opt'})
  " }
" }

" Files and fuzzy search {
  call minpac#add('tpope/vim-vinegar')
  call minpac#add('junegunn/fzf', {'do': {-> fzf#install()}})
  call minpac#add('junegunn/fzf.vim')
" }

" Tmux Interface {
  call minpac#add('christoomey/vim-tmux-navigator')
  call minpac#add('tmux-plugins/vim-tmux')
  call minpac#add('tmux-plugins/vim-tmux-focus-events')
" }

" General Programming {
  call minpac#add('preservim/nerdcommenter')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('godlygeek/tabular')
  if executable('ctags')
    call minpac#add('ludovicchabant/vim-gutentags')
    call minpac#add('preservim/tagbar')
  endif
  call minpac#add('tpope/vim-projectionist', {'type': 'opt'})
  call minpac#add('mattn/gist-vim', {'type': 'opt'})

  " Linters {
    call minpac#add('dense-analysis/ale')
  " }

  " Testing {
    call minpac#add('tpope/vim-dispatch', {'type': 'opt'})
    call minpac#add('radenling/vim-dispatch-neovim', {'type': 'opt'})
    call minpac#add('janko-m/vim-test', {'type': 'opt'})
  " }

  " Version Control {
    call minpac#add('tpope/vim-fugitive')
    call minpac#add('mhinz/vim-signify')
    call minpac#add('rhysd/conflict-marker.vim')
  " }

" }

" Snippets & AutoComplete {
  " Engines {
    call minpac#add('Shougo/deoplete.nvim', {'type': 'opt', 'do': ':UpdateRemotePlugins'})
    call minpac#add('Shougo/echodoc.vim')
    call minpac#add('SirVer/ultisnips')
  " }

  " Snippets {
    call minpac#add('honza/vim-snippets')
    call minpac#add('deoplete-plugins/deoplete-tag', {'type': 'opt'})
    call minpac#add('Shougo/deoppet.nvim', {'type': 'opt', 'do': ':UpdateRemotePlugins'})


    " Language-specific completers {
      call minpac#add('deoplete-plugins/deoplete-jedi')
      call minpac#add('wellle/tmux-complete.vim')
      call minpac#add('deoplete-plugins/deoplete-docker')
      call minpac#add('Shougo/deol.nvim', {'type': 'opt'})
      call minpac#add('Rip-Rip/clang_complete', {'type': 'opt'})
      call minpac#add('LuXuryPro/deoplete-rtags', {'type': 'opt'})
      call minpac#add('JuliaEditorSupport/deoplete-julia', {'type': 'opt'})
      call minpac#add('sudar/vim-arduino-snippets', {'type': 'opt'})
    " }
  " }
" }

" Python {
  call minpac#add('davidhalter/jedi-vim')
  call minpac#add('jmcantrell/vim-virtualenv')
  call minpac#add('python-mode/python-mode', {'type': 'opt', 'for': 'python', 'branch': 'develop' })
" }

" HTML/CSS {
  call minpac#add('alvan/vim-closetag')
  call minpac#add('gorodinskiy/vim-coloresque')
" }

" Misc {
  call minpac#add('chrisbra/csv.vim')
  call minpac#add('jalvesaq/Nvim-R', {'branch': 'stable'})
" }

" LaTeX {
  call minpac#add('lervag/vimtex', {'type': 'opt'})
  call minpac#add('KeitaNakamura/tex-conceal.vim')
  call minpac#add('xuhdev/vim-latex-live-preview')
" }

" Writing {
  call minpac#add('reedes/vim-textobj-sentence')
  call minpac#add('reedes/vim-litecorrect', {'type': 'opt'})
  call minpac#add('reedes/vim-wordy', {'type': 'opt'})
  call minpac#add('jdelkins/vim-correction', {'type': 'opt'})
" }

" Keep?
"   * vim-scripts/sessionman.vim
"   * majutsushi/tagbar

" Read docs on:
"   * tpope/vim-unimpaired
"   * tpope/vim-dispatch
"   * radenling/vim-dispatch-neovim
"   * janko/vim-test
"   * jdelkins/vim-correction
"
" Consider
"   * iliuchengxu/vista.vim
