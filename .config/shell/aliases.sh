# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Shortcuts
alias doc="cd $HOME/Documents"
alias db="cd $HOME/Dropbox"
alias c="cd $HOME/Copy"
alias dl="cd $HOME/Downloads"
alias dt="cd $HOME/Desktop"
alias g="git"
alias h="history"
alias j="jobs"

# Always use color for ls
alias ls='command ls --color'

# List all files colorized in long format
alias l="ls -lhF"

# List all files colorized in long format
alias ll="ls -alhF"

# List all files colorized in short format
alias la="ls -A"

# List all dot files colorized in long format
alias l.="ls -aldh .*"

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Loads math library with bc
alias bc="bc -l"

# Get week number
alias week="date +%V"

# Stopwatch
alias timer='echo "Timer started. Stop with Ctrl-D." && date && time cat && date'

# Get software updates
alias update="sudo apt update && sudo apt -y upgrade && sudo apt -y autoremove"

# IP addresses
alias ips="dig +short myip.opendns.com @resolver1.opendns.com"
# alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print  }'"

# # View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# Toggle R Graphics window always on top
alias rtoggle='wmctrl -r "R Graphics" -b toggle,above'

# tmux aliases
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -s"
alias restart-required='if [ -f /var/run/reboot-required ]; then cat /var/run/reboot-required; fi'

# Git config alias
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

if [ -f $HOME/.alias_local ]; then
    source $HOME/.alias_local
fi