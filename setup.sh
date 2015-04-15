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

#tmux simlink
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

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
git clone git@github.com:robbyrussell/oh-my-zsh.git ~/dotfiles/.oh-my-zsh

ln -sf ~/dotfiles/.oh-my-zsh/ ~/.oh-my-zsh
cp -f original-zsh/themes/otukutun.zsh-theme ~/dotfiles/.oh-my-zsh/themes/otukutun.zsh-theme
chsh -s /bin/zsh

#z.sh download
git clone git@github.com:rupa/z.git ~/dotfiles/z
ln -sf ~/dotfiles/z ~/z

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
