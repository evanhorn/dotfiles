# use POWERLINE
export POWERLINE_PATH="$HOME/.local/pipx/venvs/powerline-status/lib/python3.8/site-packages/powerline"

if [ -f $HOME/.local/bin/powerline-daemon ]; then
  $HOME/.local/bin/powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1

  source "$POWERLINE_PATH/bindings/bash/powerline.sh"
fi
