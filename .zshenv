setopt no_global_rcs
export EDITOR=/opt/homebrew/bin/vim
export SHELL=/usr/local/bin/zsh
export TERM=xterm-256color
export RBENV_ROOT=/usr/local/var/rbenv

export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.nodenv/bin:$PATH"
# platform-toolsディレクトリが存在する場合のみPATHに追加
ANDROID_PLATFORM_TOOLS="$HOME/Library/Android/sdk/platform-tools"
if [ -d $ANDROID_PLATFORM_TOOLS ]; then
  echo 'hello';
  export PATH="${PATH}:${ANDROID_PLATFORM_TOOLS}"
fi

export NODENV_SHELL=zsh

export LC_ALL=ja_JP.UTF-8
