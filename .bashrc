#import git-prompt
source ~/.git-prompt.sh

#import git-completion.bash
source ~/.git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\W\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '
#Alias
alias ll="ls -l"
alias vi="vim"
