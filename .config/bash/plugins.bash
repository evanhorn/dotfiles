# dircolors
if [[ -t 1 && "$(tput colors)" == "256" ]]; then
    eval "$(dircolors $HOME/.config/shell/dircolors)"
fi

# Set nvim to prevent nested operation
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    alias nvim=nvr
  else
    alias nvim='echo "No nesting!"'
  fi
fi
