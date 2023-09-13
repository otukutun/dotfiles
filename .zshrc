# Path to your oh-my-zsh installation.
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="otukutun"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
autoload -U compinit; compinit

# cdr setting
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
#---------------------------------------
## Histrory Setting
##---------------------------------------
HISTFILE=~/.zsh_history     # Histroy File
HISTSIZE=100000      
SAVEHIST=100000
setopt hist_no_store        # history command no store
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt inc_append_history   # as soon as append history


setopt AUTO_PUSHD # stack cd diretotires
setopt PUSHD_IGNORE_DUPS # don't record multimple history
autoload -Uz compinit
compinit
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby macos bundler brew rails emoji-clock dotenv)

source $ZSH/oh-my-zsh.sh

# Mac
if [ `uname` = "Darwin" ]; then
  fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
        export EDITOR='vim'
fi

# emacs keybind
bindkey -e

#Alias
alias vi='vim'
alias git='hub'

# git alias
alias g='git'
alias gd='git diff'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gct="git branch -a | awk '{ print $1 }' | grep -e 'remotes\/' | sed -e 's/remotes\///g' | peco --prompt='[git checkout -t]' | xargs git checkout -t"

# peco function
function peco-history() {
local item
item=$(builtin history -n -r 1 | peco --query="$LBUFFER")
if [[ -z "$item" ]]; then return 1
fi
BUFFER="$item"
CURSOR=$#BUFFER
}

function peco-cdr() {
local item
item=$(cdr -l | sed 's/^[^ ]\{1,\} \{1,\}//' | peco)
if [[ -z "$item" ]]; then return 1
fi
BUFFER="cd -- $item"
CURSOR=$#BUFFER
zle accept-line
}

function peco-git-branch() {
local item
item=$(git branch | peco | sed -e "s/^\*[ ]*//g")
if [[ -z "$item" ]]; then return 1
fi
BUFFER="git checkout $item"
CURSOR=$#BUFFER
zle accept-line
}

function peco-pkill() {
for pid in $(ps aux | peco | awk '{ print $2 }')
do
        kill -9 $pid
        echo "Killed ${pid}"
done
}

# easily git add
alias pgitadd="git status -s | sed -e '/^[^ |\?]/d' | peco --prompt='[git add]' | awk '{print \$2}' | xargs git add"

# easily ssh using peco.
alias pssh="grep -w Host ~/.ssh/config | peco | awk '{print \$2}' | xargs -o -n 1 ssh"

zle -N peco-history
bindkey '^x^r' peco-history 

zle -N peco-cdr
bindkey '^xb' peco-cdr

zle -N peco-git-branch
bindkey '^x^g' peco-git-branch

zle -N peco-pkill
bindkey '^x^p' peco-pkill

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Xcode change
alias xcodechange="ls /Applications | sed -e 's/\.app$//g' | grep -E '^Xcode' | peco | xargs -I{} sudo xcode-select --switch /Applications/{}.app"

# ShortCut To GitHub Pull Request Page.
alias gp='hub browse -- pull/$(git symbolic-ref --short HEAD)'

# ShortCut For StyleLint
alias slint="git diff --name-only --cached -- '*.scss' '*.css' | xargs stylelint"
# List ghq repositories.
alias lsghq='cd $(ghq list --full-path | peco )'

# Initialize nodenv
eval "$(nodenv init -)"

# Initialize rbenv
# eval "$(rbenv init -)"

