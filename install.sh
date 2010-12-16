if [ ! -f $HOME/.zshrc ]; then
  ln -s $PWD/zshrc $HOME/.zshrc
  echo "Linking .zshrc"
else
  echo "Skipping .zshrc, it already exists"
fi

if [ ! -d $HOME/.zsh ]; then
  ln -s $PWD/zsh $HOME/.zsh
  echo "Linking .zsh"
else
  echo "Skipping .zsh, it already exists"
fi

if [ ! -f $HOME/.gitconfig ]; then
  ln -s $PWD/gitconfig $HOME/.gitconfig
  echo "Linking .gitconfig"
else
  echo "Skipping .gitconfig, it already exists"
fi

if [ ! -f $HOME/.irbrc ]; then
  ln -s $PWD/irbrc $HOME/.irbrc
  echo "Linking .irbrc"
else
  echo "Skipping .irbrc, it already exists"
fi

if [ ! -f $HOME/.work_dirs ]; then
  cp $PWD/work_dirs $HOME/.work_dirs
  echo "Copying .work_dirs"
else
  echo "Skipping .work_dirs, it already exists"
fi
