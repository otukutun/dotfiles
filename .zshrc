# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="otukutun"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# autoload -U compinit; compinit
autoload -Uz compinit && compinit

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
alias gsw='git switch'
alias gswc='git switch -c'
alias gswt='git switch -t'
alias ga='git add'
alias gc='git commit'
alias gr='git restore'
alias gp='git push'
# REF: https://zenn.dev/mary_pp/articles/eaac544eaf600a
alias gpf='git push --force-with-lease --force-if-includes'

# for docker
alias d='docker'

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
BUFFER="git switch $item"
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

# REF: https://www.jetbrains.com/help/phpstorm/opening-files-from-command-line.html#macos
function peco-phpstorm() {
  appPath="/Applications/PhpStorm.app"
  if [ -d "$appPath" ]; then
    ghq list --full-path | peco | xargs open -na "PhpStorm.app" --args "$@"
  else
    return 1;
  fi
}
alias phpstorm="peco-phpstorm"

# tmuxinatorで実現しようとしたが、随時立ち上げたいProjectに対応したいのでこれを作った
# REF: https://zenn.dev/azunasu/articles/25d9999ca0fb96?utm_source=pocket_saves#%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%82%92%E7%94%A8%E6%84%8F%E3%81%99%E3%82%8B
# フロントエンドの階層が同じの場合
function setup-web-on-tmux() {
  # ペインを左右に分割する
  tmux splitw -h

  # 右のペインに移動後、ペインを上下に分割
  tmux splitw -v

  # 左のペインを使う
  tmux selectp -L

  # バックエンドを起動する
  # send-keysでキー入力。
  tmux send-keys 'git pull' C-m
  tmux send-keys 'docker-compose up' C-m

  # 右のペインを使う
  tmux selectp -R
  tmux selectp -U

  # フロントエンドを起動する
  # send-keysでキー入力。
  tmux send-keys 'yarn start' C-m

  # 右下のペインを使う
  tmux selectp -D
}

# フロントエンドの階層が別の場合
function setup-web2-on-tmux() {
  # ペインを左右に分割する
  tmux splitw -h

  # 右のペインに移動後、ペインを上下に分割
  tmux splitw -v

  # 左のペインを使う
  tmux selectp -L

  # バックエンドを起動する
  # send-keysでキー入力。
  tmux send-keys 'git pull' C-m
  tmux send-keys 'docker-compose up' C-m

  # 右のペインを使う
  tmux selectp -R
  tmux selectp -U

  # フロントエンドを起動する
  # send-keysでキー入力。
  readonly target="$1"
  tmux send-keys "cd ${target}" C-m
  tmux send-keys 'yarn start' C-m

  # 右下のペインを使う
  tmux selectp -D
}


# easily git add
alias pgitadd="git status -s | sed -e '/^[^ |\?|^A]/d' | peco --prompt='[git add]' | awk '{print \$2}' | xargs git add"

# git switch from remote
alias pgitswitchr="git branch -a | awk '{ print $1 }' | grep -e 'remotes\/origin\/' | sed -e 's/remotes\/origin\///g' | peco --prompt='[git switch]' | xargs git switch"

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

# Xcode change
alias xcodechange="ls /Applications | sed -e 's/\.app$//g' | grep -E '^Xcode' | peco | xargs -I{} sudo xcode-select --switch /Applications/{}.app"

# ShortCut To GitHub Pull Request Page.
alias pr='hub browse -- pull/$(git symbolic-ref --short HEAD)'
alias prl="gh search prs --state=open --review-requested=@me --json title,url,repository | jq -r '.[] | \"[\(.repository.name)] \(.title) \(.url)\"'"

# List ghq repositories.
alias pghq='cd $(ghq list --full-path | peco )'

# Initialize nodenv
eval "$(nodenv init -)"

# Initialize rbenv
# eval "$(rbenv init -)"
eval "$(~/.rbenv/bin/rbenv init - zsh)"

# Initialize direnv
eval "$(direnv hook zsh)"

# Init private alias
PRIVATE_ALIAS=~/dotfiles/.zsh_private
if [ -e $PRIVATE_ALIAS ]; then
  source $PRIVATE_ALIAS
fi

