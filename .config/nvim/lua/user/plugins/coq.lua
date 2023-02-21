-- vim: set foldmarker={,} foldlevel=0 foldmethod=marker:

  vim.g.coq_settings = {
    auto_start = true,
    keymap  = {
      jump_to_mark = '<C-o>',
      eval_snips = '<leader>j',
    },
  }

require("coq_3p") {
  { src = "repl", max_lines = 99, deadline = 500, unsafe = { "sudo", "rm", "poweroff", "mv", "shutdown", "reboot" }, },
  { src = "nvimlua", short_name = "nLUA", conf_only = true },
  { src = "bc", short_name = "MATH", precision = 6 },
  { src = "figlet", short_name = "BIG" },
  { src = "vimtex", short_name = "vTEX" },
}
