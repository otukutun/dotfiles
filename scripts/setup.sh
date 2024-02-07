#!/bin/sh

cd ~

# Simlink for zsh, vim git
#.zsh_privateは.zshrcから呼び出される。公開できないものはこちらに記載する
links=(
  .zshrc
  .zshenv
  .vimrc
  .vim
  .gitignore
  .gitconfig
  .gitignore_global
  .peco
  .tmux.conf
)

for link in $links; do
  ln -sf "$HOME/dotfiles/$link" "$HOME/$link"
done

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

git clone git://github.com/seebi/dircolors-solarized ~/dotfiles/.vim/bundle/dircolors-solarized

