# Increase history file size and set history location
HISTSIZE=100000
HISTFILE="$HOME/.config/bash/bash_history"
SAVEHIST=$HISTSIZE

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source ~/.local/bin/virtualenvwrapper.sh

# set vimconfig directory and add fzf to path
export VIMCONFIG=$HOME/.config/nvim
export PATH=$PATH:$VIMCONFIG/pack/minpac/start/fzf/bin

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
