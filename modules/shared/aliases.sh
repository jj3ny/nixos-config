## For now, safe to delete -- not being used.
# Navigation Aliases
alias dev="cd ~/Development"
alias legal="cd ~/Development/legal"
alias exp="cd ~/Development/experimental"
alias research="cd ~/Development/research"
alias tools="cd ~/Development/tools"
alias odocs="cd /Users/johnhughes/Library/CloudStorage/OneDrive-Personal/Documents"
alias ocode="cd /Users/johnhughes/Library/CloudStorage/OneDrive-Personal/Documents/Code"
alias gdrive="cd /Users/johnhughes/Library/CloudStorage/GoogleDrive-john.j.hughes@gmail.com/'My Drive'"

# Git Aliases
alias g="git"
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gpr="git pull --rebase"
alias lg="lazygit"

# Development Aliases
alias dc="docker-compose"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias pn="pnpm"
alias px="pnpx"
alias run="nodemon"
alias serve="live-server"
alias c="clear"
alias h="history"
alias p="poetry run python"
alias path='echo $PATH | tr ":" "\n"'

# Enhanced CLI Replacements
alias ls="ls --color=auto"
alias ll="eza -lh --icons"
alias cat="bat"
alias find="fd"
alias tree="broot"
alias diff="difft"

# System and Utility Aliases
alias update="nix-channel --update && nix-env -u"
alias edit="emacsclient -t"
alias search="rg --glob '!.git/*' --glob '!node_modules/*'"
alias helpme="cat ~/.aliases.helpme"