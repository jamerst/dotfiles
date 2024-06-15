
# GENERAL ALIASES
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias del='gio trash'
alias rm='rm -i'

alias chex='chmod u+x'
alias ch644='chmod 644'
alias ch755='chmod 755'

# FIXES
alias sudo='sudo ' # Enable aliases to be sudo'ed

# DOCKER
alias dcup='docker compose up'
alias dcs='docker compose stop'
alias dcb='docker compose build'
function cbash() { docker exec -it $1 bash ${@:2} }

# DNF
alias dnfup='sudo dnf upgrade'
alias dnfinst='sudo dnf install'

# FZF
alias preview="fzf --preview 'bat --color \"always\" {}'"

# GCC
function gccr() { gcc $1 -o `x=$1; echo ${x%.c}`; ./`x=$1; echo ${x%.c}` }
function gccd() { gcc -g $1 -o `x=$1; echo ${x%.c}` && gdb ./`x=$1; echo ${x%.c}` }

# GIT
function gclj() { git clone git@github.com:jamerst/$1.git ${@:2} }
function gclgh() { git clone git@github.com:$1.git ${@:2} }

# LS
alias l='eza -l --group-directories-first --time-style long-iso'
alias lg='eza -lg --group-directories-first --time-style long-iso'
alias la='eza -la --group-directories-first --time-style long-iso'
alias lga='eza -lga --group-directories-first --time-style long-iso'
function lc() { cd "$1" && l }

# NCDU
alias ncdu='ncdu --color dark'

# NPM/PNPM
alias pnpm-check='NPM_CHECK_INSTALLER=pnpm npm-check -u'

# ZSH CONFIG SHORTCUTS
alias antidote-bundle='source ~/src/dotfiles/zsh/antidote/antidote.zsh; antidote bundle < ~/src/dotfiles/zsh/zsh_plugins > ~/src/dotfiles/zsh/zsh_plugins.sh'