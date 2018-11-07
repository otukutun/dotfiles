setopt no_global_rcs
export EDITOR=/usr/local/bin/vim
export SELL=/usr/local/bin/zsh
export TERM=xterm-256color
export RBENV_ROOT=/usr/local/var/rbenv

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

eval "$(direnv hook zsh)"

export LC_ALL=ja_JP.UTF-8
