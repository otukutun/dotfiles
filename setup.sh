#!/bin/sh

cd ~
#mkdir bin swap backup tmp memo tags src .trash .tmux

#zsh simlink
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zshenv ~/.zshenv

#vim simlink
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim ~/.vim

#git simlink
ln -sf ~/dotfiles/.gitignore ~/.gitignore
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global

#tmux simlink
if [ `uname` = "Darwin" ]; then
  ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
else
  ln -sf ~/dotfiles/.ubuntu_tmux.conf ~/.tmux.conf
fi
#for mac simlink
ln -sf ~/dotfiles/Brewfile ~/Brewfile

# Mac
if [ `uname` = "Darwin" ]; then
  if [ -z `which brew` ]; then
    # home brew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # php
    #curl -s http://php-osx.liip.ch/install.sh | bash -s 5.5
  fi
  brew tap Homebrew/bundle
  brew bundle
  brew bundle cleanup
fi

cd ~/dotfiles/

ssh_dir=~/.ssh
if [ ! -d $ssh_dir ]; then
  mkdir ~/.ssh
fi

ln -sf ~/dotfiles/.ssh_config ~/.ssh/config

#oh-my-zsh download
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/dotfiles/.oh-my-zsh

ln -sf ~/dotfiles/.oh-my-zsh/ ~/.oh-my-zsh
cp -f original-zsh/themes/otukutun.zsh-theme ~/dotfiles/.oh-my-zsh/themes/otukutun.zsh-theme
chsh -s /bin/zsh

#neobundle,tmux,color-theme
mkdir -p ~/.vim/bundle

#tmuxinator install
gem install tmuxinator
gem install aws-sdk
gem install ec2ssh
gem install rubocop
gem install refe2

ln -sf ~/dotfiles/.tmuxinator ~/.tmuxinator

# peco setting
ln -sf ~/dotfiles/.peco ~/.peco

# gemrc setting
ln -sf ~/dotfiles/.gemrc ~/.gemrc

#mkdir -p ~/.vim/colors
#curl -S -o ~/dotfiles/.vim/colors/Tomorrow-Night-Eightie.vim https://raw.githubusercontent.com/chriskempson/tomorrow-theme/master/vim/colors/Tomorrow-Night-Eighties.vim

#vim plugin install
git clone git://github.com/Shougo/neobundle.vim ~/dotfiles/.vim/bundle/neobundle.vim
git clone git://github.com/erikw/tmux-powerline ~/dotfiles/.vim/bundle/tmux-powerline
git clone git://github.com/seebi/dircolors-solarized ~/dotfiles/.vim/bundle/dircolors-solarized
vim  +NeoBundleInstall +q

# if vimproc says `vimproc's DLL: "~/dotfiles/.vim/bundle/vimproc/autoload/vimproc_mac.so" is not found.  Please read :help vimproc and make it.`
# you should execute this command.
# $ cd .vim/bundle/vimproc && make
# source: http://d.hatena.ne.jp/pospome/20141202/1417494524
