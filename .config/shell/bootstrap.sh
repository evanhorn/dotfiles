# set PATH so it includes user's private bin if it exists

if [ -d "$HOME/.nvm" ] ; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

if [ -s "$HOME/.cargo/env" ] ; then
  source "$HOME/.cargo/env"
fi

for LOCAL_PATH in ".rvm/bin" "bin" ".local/bin"; do
  if [ -d "$HOME/$LOCAL_PATH" ] ; then
    path_prepend "$HOME/$LOCAL_PATH"
  fi
done

if [[ $(type -t pyenv) == function ]] ; then
  # So pyenv gets recognized
  eval "$(pyenv init -)"
  # Load pyenv-virtualenv automatically
  eval "$(pyenv virtualenv-init -)"
fi
