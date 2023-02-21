-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

require("nvim-treesitter.configs").setup{
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
    disable = { "sh", "bash", "latex" },
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true, disable = { "" }, },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        --   -- f keymaps are for key-values
        --   ["af"] = "@function.outer",
        --   ["if"] = "@function.inner",
        --   -- c keymaps are for dictionaries
        --   ["ac"] = "@class.outer",
        --   ["ic"] = "@class.inner",
        --   -- k keymaps are for comments
        --   ["ak"] = "@comment.outer",
        --   ["ik"] = "@comment.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      -- Granular control over motions on key-values and dictionaries
      -- if you want it
    },
    swap = {
      enable = true,
      -- Swap parameters; ie. if a key-value has multiple values and you want to swap them
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      -- Press v. inside a key-value or a comment (then . or ; repeatedly)
      ['.'] = 'textsubjects-smart',
      -- Press v; to select surrounding dictionary
      [';'] = 'textsubjects-container-outer',
    }
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
}

-- Context display for long dictionaries and key-value entries (
require("treesitter-context").setup{
  throttle = true,
  patterns = {
    -- This will show context for functions, classes and mehod
    -- in all languages
    default = { 'function', 'class', 'method' },
    -- In OpenFOAM files, we have dicts and key-val pairs
    -- (you might want to add '^list')
    foam = { '^dict$', '^key_value$' }
  },
  -- Make sure foam is treated with exact Lua patterns
  exact_patterns = { foam = true, }
}
-- )
