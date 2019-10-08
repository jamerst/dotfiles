
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

# FZF
alias preview="fzf --preview 'bat --color \"always\" {}'"
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(subl {})+abort'"

# GCC
function gccr() { gcc $1 -o `x=$1; echo ${x%.c}`; ./`x=$1; echo ${x%.c}` }
function gccd() { gcc -g $1 -o `x=$1; echo ${x%.c}` && gdb ./`x=$1; echo ${x%.c}` }

# GIT
function gclj() { git clone git@github.com:jamerst/$1.git $2 $3 $4}

# HOSTNAMES
alias joshua='joshua.dcs.warwick.ac.uk'
alias raw='radio.warwick.ac.uk'

# LS - REPLACES SOME IN ~/.oh-my-zsh/lib/directories.zsh
alias l='exa -l --group-directories-first --time-style long-iso'
alias la='exa -la --group-directories-first --time-style long-iso'
function lc() { cd "$1" && l }

# NCDU
alias ncdu='ncdu --color dark'

# SSH
alias sshw='ssh u1708480@login-3.dcs.warwick.ac.uk'
function scpw() { scp u1708480@login-3.dcs.warwick.ac.uk $@ }
alias sshr='ssh jtattersall@radio.warwick.ac.uk'

# WARWICK
# CS263 Decrypt
function 236ssl() { openssl enc -in $1 -d -aes-256-cbc -pass pass:$2 -md md5 > `x=$1; echo ${x%.enc}` }

# ZSH CONFIG SHORTCUTS
alias zshconf='code ~/.zshrc'
alias omz='xdg-open ~/.oh-my-zsh &'
alias zsh_plugins_update='antibody bundle < ~/src/dotfiles/zsh/zsh_plugins > ~/src/dotfiles/zsh/zsh_plugins.sh'