#!/bin/bash

#
# Prepare minimal set of tools
#
if [ "$(uname -s)" = "Linux" ]; then
  sudo apt -y install curl git vim
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install curl git vim tig vim mc picocom zsh wget htop btop aider cyme
fi

#
# check and if necessary install oh-my-zsh
#
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

#
# Backup current path
#
pushd .

#
# link my config
#
cd ~/
ln -s .zsh/tmux/tmux.conf ~/.tmux.conf
ln -s .zsh/git/gitconfig ~/.gitconfig
ln -s .zsh/git/gitignore ~/.gitignore
rm ~/.zshrc
ln -s .zsh/zshrc ~/.zshrc
ln -s .zsh/p10k.zsh ~/.p10k.zsh

if [ "$(uname -s)" = "Linux" ]; then
  ln -s .zsh/zshrc.linux.user ~/.zshrc.linux.user
else
  ln -s .zsh/zshrc.user ~/.zshrc.user
fi
ln -s .zsh/vimrc ~/.vimrc
cd .zsh/

#
# install zsh autosuggestions
#
if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi

#
# install powerlevel 10 support
#
if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
fi

if [[ $(uname -o) == "GNU/Linux" ]]
then
  mkdir -p ${HOME}/.local/share/fonts/ttf
  wget https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip -O /tmp/fonts.zip
  pushd .
  cd ${HOME}/.local/share/fonts/ttf
  unzip /tmp/fonts.zip
  popd
fi
popd

#
# VIM Dracula
#
if [ ! -d ~/.vim/pack/themes/start/dracula ]; then
  mkdir -p ~/.vim/pack/themes/start
  pushd .
  cd ~/.vim/pack/themes/start
  git clone https://github.com/dracula/vim.git dracula
fi

#
# packadd! dracula
# syntax enable
# colorscheme dracula
#

#
# restore old path
#
popd
echo "Install done, please logout and login again"
