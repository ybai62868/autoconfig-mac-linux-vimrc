#!/bin/bash
# @author Yang Bai<ybai62868@gmail.com>

[[ -d ~/.vim ]] || mkdir ~/.vim;

# tmp dir
[[ -d ~/v-tmp ]] || mkdir ~/v-tmp;

# .vimrc
cd ~/v-tmp;
[[ -d ~/v-tmp/rc ]] || git clone https://github.com/barretlee/autoconfig-mac-vimrc.git;

# backup origin vimrc file
[[ -f ~/.vimrc-bak ]] || cp ~/.vimrc ~/.vimrc-bak;
mv ~/v-tmp/autoconfig-mac-vimrc/.vimrc ~/.vimrc;

# vim pulgin controller - vundle
[[ -d ~/.vim/bundle/Vundle.vim ]] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim;

# colors schemes
cd ~/v-tmp;
[[ -d ~/v-tmp/vim-colorschemes ]] || git clone https://github.com/flazz/vim-colorschemes.git;
[[ -d ~/.vim/colors ]] || mv ~/v-tmp/vim-colorschemes/colors ~/.vim/;

# fonts for airline
cd  ~/v-tmp;
[[ -d ~/v-tmp/fonts ]] || git clone https://github.com/powerline/fonts.git;
cd fonts;
sh ./install.sh;

if type brew > /dev/null; then
  echo "Homebrew Exists";
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
fi;

# ack supported
brew install ack ag;

# exuberant ctags
brew install ctags-exuberant
# alias ctags='/usr/local/bin/ctags'

# YouCompleteMe supported
if [[ -d ~/.vim/bundle/YouCompleteMe ]]; then
  echo "YouCompleteMe Exists";
else
  git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe;
  cd ~/.vim/bundle/YouCompleteMe;
  git submodule update --init --recursive
  # for nodejs
  python ./install.py --clang-completer;
fi;

# update vim, replace the origin
brew install vim;
# alias vim='/usr/local/bin/vim'

# install vim plugins
vim +PluginInstall! +qall;

# rm tmp dir
rm -rf ~/v-tmp;
# echo "You can remove the temporary directory ~/v-tmp";
