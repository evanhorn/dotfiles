# use POWERLINE
if [ -f $HOME/.local/bin/powerline-daemon ]; then
  $HOME/.local/bin/powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1

  export POWERLINE_COMMAND=$HOME/.local/bin/powerline
  source "`python -m site --user-site`/powerline/bindings/bash/powerline.sh"
fi
