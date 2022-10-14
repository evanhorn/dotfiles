# Increase history file size and set history location
HISTSIZE=100000
HISTFILE="$HOME/.config/bash/bash_history"
SAVEHIST=$HISTSIZE

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python3
source $HOME/.local/bin/virtualenvwrapper.sh

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# add fzf to path
if [ -f ~/.fzf.bash ]
then
  source ~/.fzf.bash

  # Note: had to change __fzf_defc "$cmd" _fzf_dir_completion "-o nospace -o dirnames"
  # to __fzf_defc "$cmd" _fzf_dir_completion "-o default -o bashdefault -o dirnames"
  # in /shell/completions.bash

  # Host completion
  _fzf_complete_ssh_notrigger() {
      FZF_COMPLETION_TRIGGER='' _fzf_host_completion
  }

  complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ssh
  complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger mosh
  complete -o bashdefault -o default -F _fzf_complete_ssh_notrigger ss

  # use fd for fzf
  if fd --version > /dev/null 2>&1
  then
    export FZF_DEFAULT_COMMAND="fd --type file --color=always"
    export FZF_DEFAULT_OPTS="--ansi"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

fi
# set vimconfig directory
export VIMCONFIG=$HOME/.config/nvim

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
  shopt -s "$option" 2> /dev/null;
done;

# set -o noclobber
export LS_OPTIONS='-F -N --color=auto -T 0'
export EDITOR=/usr/bin/vi
export PYTHONBREAKPOINT=pudb.set_trace
