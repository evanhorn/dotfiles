" vim: set foldmarker={,} foldlevel=0 foldmethod=marker spell:

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
