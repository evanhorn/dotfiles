-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

local bind = vim.keymap.set


-- tex-conceal {
  vim.g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
  vim.g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
  vim.g.tex_conceal = "abdmgs"
-- }

-- vimtex {
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_fold_enabled = 1
  vim.g.vimtex_quickfix_mode = 0
  vim.g.vimtex_doc_handlers = 'vimtex#doc#handlers#texdoc'
  vim.g.vimtex_grammar_textidote = {
        jar = '/opt/textidote/textidote.jar',
        }

  -- TOC settings
  vim.g.vimtex_toc_config = {
        name = 'TOC',
        layers = {'content', 'todo', 'include'},
        split_width = 50,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
        mode = 2,
        }
-- }

-- vim-textidote {
vim.g.textidote_jar = '/opt/textidote/textidote.jar'
-- }

-- vim-angry-reviewer {
bind('n', '<localleader>ar', ':AngryReviewer<cr>')
vim.g.AngryReviewerEnglish = 'american'
-- }
