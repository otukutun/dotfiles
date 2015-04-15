FILES=(.bashrc .zshrc .oh-my-zsh .vimrc .tmux.conf .vim .gitignore .gitconfig Brewfile z .tmuxinator dotfiles) 

for file in ${FILES[@]}; do
  if [ -e $file ]; then
    echo "~/$file"
    rm -rf "~/$file"
  fi
done
