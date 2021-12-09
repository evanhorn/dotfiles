# Functions
source $HOME/.config/shell/functions.sh

# Allow local customizations in the $HOME/.shell_local_before file
if [ -f $HOME/.shell_local_before ]; then
    source $HOME/.shell_local_before
fi

# Allow local customizations in the $HOME/.bashrc_local_before file
if [ -f $HOME/.bashrc_local_before ]; then
    source $HOME/.bashrc_local_before
fi

# source git completion
if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

# Settings
source $HOME/.config/bash/settings.bash

# Bootstrap
source $HOME/.config/shell/bootstrap.sh

# Aliases
source $HOME/.config/shell/aliases.sh

# Custom prompt
source $HOME/.config/bash/prompt.bash

# Plugins
source $HOME/.config/bash/plugins.bash

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Allow local customizations in the $HOME/.shell_local_after file
if [ -f $HOME/.shell_local_after ]; then
    source $HOME/.shell_local_after
fi

# Allow local customizations in the $HOME/.bashrc_local_after file
if [ -f $HOME/.bashrc_local_after ]; then
    source $HOME/.bashrc_local_after
fi

eval "$(register-python-argcomplete pipx)"
