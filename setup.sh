#!/bin/sh

cd ~
mkdir bin swap backup tmp memo tags src .trash .tmux
mkdir -p ~/etc/profile.d

#git
curl -S -o ~/dotfiles/git-prompt.sh https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
curl -S -o ~/dotfiles/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash


#bash or zsh simlink
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc

#bash'sgit config simlink
ln -sf ~/dotfiles/git-prompt.sh ~/.git-prompt.sh
ln -sf ~/dotfiles/git-completion.bash ~/.git-completion.bash

#vim simlink
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim

#git simlink
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig

#for mac simlink
ln -sf ~/dotfiles/Brewfile ~/Brewfile

# Mac
if [ `uname` = "Darwin" ]; then
  if [ -z `which brew` ]; then
    # home brew
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
    # php
    curl -s http://php-osx.liip.ch/install.sh | bash -s 5.5
  fi
  brew bundle
fi
cd ~/dotfiles/

#oh-my-zsh download
git clone git@github.com:robbyrussell/oh-my-zsh.git ~/dotfiles/oh-my-zsh.git

#oh-my-zsh setting
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | ZSH=~/dotfiles/zsh sh

#neobundle,tmux,color-theme
git clone git://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
git clone git://github.com/erikw/tmux-powerline ~/dotfiles/.vim/bundle/tmux-powerline
git clone git://github.com/seebi/dircolors-solarized ~/dotfiles/.vim/bundle/dircolors-solarized
vim  +NeoBundleInstall +q
