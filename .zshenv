export EDITOR=/usr/local/bin/vim
export SELL=/usr/local/bin/zsh
export TERM=xterm-256color
export RBENV_ROOT=/usr/local/var/rbenv

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
