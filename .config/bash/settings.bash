# Increase history file size and set history location
HISTSIZE=100000
HISTFILE="$HOME/.config/bash/bash_history"
SAVEHIST=$HISTSIZE

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
