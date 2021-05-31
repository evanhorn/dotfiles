# Setup fzf
# ---------
if [[ ! "$PATH" == */home/evanhorn/.config/nvim/pack/minpac/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/evanhorn/.config/nvim/pack/minpac/start/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/evanhorn/.config/nvim/pack/minpac/start/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/evanhorn/.config/nvim/pack/minpac/start/fzf/shell/key-bindings.bash"
