# Alias
alias ll='ls -la'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'
alias vim='nvim'

# Prompt
PS1='\[\e[0;32m\]\u@\h \[\e[0;33m\]~ \w \[\e[0m\]$$ '

# Path
export PATH=$PATH:$HOME/scripts

# Custom functions

# Make a directory and change into it
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

# copy a directory with all his content
cpdir() {
    cp -r $1 $2
}
