# Setup fzf
# ---------
if [[ ! "$PATH" == */home/evanhorn/.local/share/nvim/plugged/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/evanhorn/.local/share/nvim/plugged/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/evanhorn/.local/share/nvim/plugged/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/evanhorn/.local/share/nvim/plugged/fzf/shell/key-bindings.bash"
