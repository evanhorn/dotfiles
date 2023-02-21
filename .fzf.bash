# Setup fzf
# ---------
if [[ ! "$PATH" == */home/evanhorn/.local/share/nvim/lazy/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/evanhorn/.local/share/nvim/lazy/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/evanhorn/.local/share/nvim/lazy/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/evanhorn/.local/share/nvim/lazy/fzf/shell/key-bindings.bash"