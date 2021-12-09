# .bash_profile

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

eval "$(pyenv init --path)"
