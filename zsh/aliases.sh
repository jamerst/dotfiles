
# GENERAL ALIASES
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias del='trash-put'
alias rm='rm -i'

alias chex='chmod u+x'
alias ch644='chmod 644'
alias ch755='chmod 755'

alias path='echo -e ${PATH//:/\\n}'

# FIXES
# Enable aliases to be sudo'ed
alias sudo='sudo '

# DOCKER
alias dcup='docker-compose up'
alias dcb='docker-compose build'
function cbash() { docker exec -it $1 bash ${@:2} }

# FZF
alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(subl {})+abort'"

# GCC
function gccr() { gcc $1 -o `x=$1; echo ${x%.c}`; ./`x=$1; echo ${x%.c}` }
function gccd() { gcc -g $1 -o `x=$1; echo ${x%.c}` && gdb ./`x=$1; echo ${x%.c}` }

# GIT
function gclj() { git clone git@github.com:jamerst/$1.git ${@:2} }

# LS
alias l='exa -l --group-directories-first --time-style long-iso'
alias la='exa -la --group-directories-first --time-style long-iso'
function lc() { cd "$1" && l }

# NCDU
alias ncdu='ncdu --color dark'

# SSH
alias sshw='ssh u1708480@cobra-02.dcs.warwick.ac.uk'
function scpw() { scp u1708480@cobra-02.dcs.warwick.ac.uk $@ }

# ZSH CONFIG SHORTCUTS
alias zshconf='code ~/.zshrc'
alias zsh_plugins_update='antibody bundle < ~/src/dotfiles/zsh/zsh_plugins > ~/src/dotfiles/zsh/zsh_plugins.sh'