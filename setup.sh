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

#tmux,color-theme

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

git clone git://github.com/erikw/tmux-powerline ~/dotfiles/.vim/bundle/tmux-powerline
git clone git://github.com/seebi/dircolors-solarized ~/dotfiles/.vim/bundle/dircolors-solarized
