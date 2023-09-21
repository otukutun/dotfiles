FILES=(.zshrc .oh-my-zsh .vimrc .tmux.conf .vim .gitignore .gitconfig .gitignore_global Brewfile .tmuxinator dotfiles) 

for file in ${FILES[@]}; do
  if [ -e $file ]; then
    echo "~/$file"
    rm -rf "~/$file"
  fi
done
